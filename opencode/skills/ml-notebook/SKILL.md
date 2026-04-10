---
name: ml-notebook
description: Analyse and improve Jupyter notebooks for ML projects — validates methods, enforces coding style, optimises for model efficiency vs runtime tradeoffs, and standardises matplotlib/plotting output
license: MIT
---

## Before touching anything

Read the entire notebook top to bottom first. Do not suggest changes until you have a complete picture of:

- The ML task (classification, regression, clustering, generation, etc.)
- The dataset shape, size, and type (tabular, image, text, time-series)
- The full pipeline: ingestion → preprocessing → training → evaluation → visualisation
- Which framework(s) are in use: scikit-learn, PyTorch, TensorFlow/Keras, XGBoost, HuggingFace, etc.
- Hardware context if inferable: GPU present? Large dataset? Memory-constrained?
- Whether this is exploratory (EDA notebook) or production-bound (training pipeline)

Do not assume the notebook is complete. It may be mid-development.

---

## Structure to enforce

Every ML notebook should follow this cell order. Flag deviations clearly.

```
1. Title cell (Markdown)        — purpose, author, date, dataset, task type
2. Imports                      — all imports in one cell, grouped
3. Config / constants           — all magic numbers and paths in one place
4. Data loading                 — raw load only, no transforms here
5. Exploratory analysis         — shape, dtypes, nulls, distributions
6. Preprocessing                — transforms, splits, scaling, encoding
7. Model definition             — architecture or estimator setup
8. Training                     — fit loop or .fit() call
9. Evaluation                   — metrics, confusion matrix, etc.
10. Visualisation               — all plots
11. Conclusions / next steps    — Markdown summary
```

If the notebook is purely EDA, sections 7–9 are optional but note their absence.

---

## Imports

**Grouping order** (PEP8 + ML convention):

```python
# 1. stdlib
import os
import time
from pathlib import Path

# 2. data / numerical
import numpy as np
import pandas as pd

# 3. visualisation
import matplotlib.pyplot as plt
import matplotlib as mpl
import seaborn as sns

# 4. ML framework
import torch
import torch.nn as nn
from torch.utils.data import DataLoader, Dataset

# 5. sklearn utilities
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import classification_report

# 6. project-local
from src.models import MyModel
from src.utils import seed_everything
```

Flag: imports scattered across cells, star imports (`from x import *`), duplicate imports, importing inside loops or functions without justification.

---

## Config block

All of the following must live in a single config cell near the top, not scattered inline:

```python
# Paths
DATA_DIR   = Path("data/raw")
OUTPUT_DIR = Path("outputs")
MODEL_DIR  = Path("models")

# Reproducibility
SEED = 42

# Data
TEST_SIZE   = 0.2
VAL_SIZE    = 0.1

# Training
BATCH_SIZE  = 64
EPOCHS      = 50
LR          = 1e-3
WEIGHT_DECAY = 1e-4

# Model
HIDDEN_DIM  = 256
DROPOUT     = 0.3
NUM_CLASSES = 10

# Hardware
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")
```

Flag: magic numbers inline in model definitions, hardcoded paths in data loading cells, learning rates defined mid-cell.

---

## Reproducibility

Every notebook must set seeds before any randomness. Check for all of:

```python
import random
random.seed(SEED)
np.random.seed(SEED)
torch.manual_seed(SEED)
torch.cuda.manual_seed_all(SEED)
# For sklearn pipelines:
# pass random_state=SEED to every estimator that accepts it
```

Flag: seeds set in only one library when multiple are used, seeds set after data splitting, `random_state` missing from sklearn estimators.

---

## Data handling

**Loading**
- Use `Path` objects not raw strings for file paths
- Check file existence before loading: `assert DATA_DIR.exists()`
- Print shape and dtypes immediately after loading — every time

**Validation checks to include or flag as missing:**

```python
print(df.shape)
print(df.dtypes)
print(df.isnull().sum())
print(df.duplicated().sum())
print(df.describe())
```

**Splits**
- Train/val/test splits must be done before any preprocessing that could cause leakage
- Scaler/encoder must be fit on train only, then transform val and test separately
- Flag any `.fit_transform()` called on the full dataset before splitting

**Memory**
- For large DataFrames, suggest dtype downcast:

```python
df[col] = df[col].astype("float32")    # not float64
df[col] = df[col].astype("int32")      # not int64 if range allows
df[col] = df[col].astype("category")   # for low-cardinality strings
```

- For PyTorch: flag missing `pin_memory=True` in DataLoader when GPU is in use
- Flag loading entire dataset into GPU memory when iterative loading is feasible

---

## Preprocessing quality checks

- Label encoding: warn if ordinal encoding is applied to nominal features without justification
- Scaling: flag if tree-based models (XGBoost, RandomForest, LightGBM) are being scaled unnecessarily — they are invariant to monotonic transforms
- Feature leakage: flag any column derived from the target that is kept as a feature
- Class imbalance: if classification task, check `y.value_counts()` is present; flag if imbalance > 5:1 with no handling strategy noted

---

## Model definition

**PyTorch**

Check for:
- `nn.Module` subclass with `__init__` and `forward` defined
- No tensor operations in `__init__`
- Activation functions instantiated in `__init__`, not called as functions in `forward` (prefer `self.relu = nn.ReLU()` over `F.relu()` for consistency — note this is a style preference, not a correctness issue)
- `model.to(DEVICE)` called after instantiation

Flag:
- Hardcoded input dimensions that should reference data shape
- Missing `model.train()` / `model.eval()` switching
- Missing `torch.no_grad()` in evaluation loops
- Gradient accumulation not used when batch size is small due to memory constraints

**sklearn**

Check for:
- Pipeline wrapping preprocessing + estimator (prevents leakage, enables cross-validation)
- `random_state` set on all stochastic estimators
- `n_jobs=-1` considered for parallelisable estimators (flag if absent on slow fits)

---

## Training loop quality (PyTorch)

A correct minimal loop looks like:

```python
for epoch in range(EPOCHS):
    model.train()
    for batch_X, batch_y in train_loader:
        batch_X, batch_y = batch_X.to(DEVICE), batch_y.to(DEVICE)
        optimiser.zero_grad()
        outputs = model(batch_X)
        loss = criterion(outputs, batch_y)
        loss.backward()
        optimiser.step()

    model.eval()
    with torch.no_grad():
        # validation pass
```

Flag any of these missing. Also flag:
- Loss logged only at end of epoch (should log every N steps for long epochs)
- No gradient clipping when using RNNs/LSTMs: `torch.nn.utils.clip_grad_norm_`
- Checkpoint saving absent for runs > 10 epochs
- Learning rate scheduler defined but `.step()` never called

---

## Efficiency vs runtime tradeoffs

When suggesting optimisations, always state the tradeoff explicitly.
Use this framework:

### Memory efficiency (smaller footprint, potentially slower)
- Gradient checkpointing: `torch.utils.checkpoint`
- Mixed precision: `torch.cuda.amp.autocast()` — reduces memory ~50%, marginal speed loss on modern GPUs
- Smaller batch size with gradient accumulation

### Runtime efficiency (faster, potentially more memory)
- `pin_memory=True` + `num_workers > 0` in DataLoader
- `torch.compile()` (PyTorch 2.0+) — significant speedup, longer first-run compilation
- `num_workers` in DataLoader set to CPU count: `os.cpu_count()`
- Mixed precision with `GradScaler` — faster AND smaller on CUDA hardware

### Model efficiency (fewer parameters, usually both)
- Knowledge distillation (flag as architectural suggestion only)
- Quantisation post-training: `torch.quantization` — flag as suggestion with caveats
- Pruning: flag as suggestion only, not automated

### When to suggest what
- Small dataset + large model → flag overfitting risk, suggest dropout/regularisation first
- Large dataset + slow training → suggest DataLoader workers, mixed precision
- OOM errors evident (or likely) → suggest gradient checkpointing, smaller batch + accumulation
- Inference speed concern → suggest `torch.compile`, quantisation, batch inference
- sklearn on large data → suggest incremental learners (`SGDClassifier`, `MiniBatchKMeans`)

Never suggest a GPU optimisation without first checking DEVICE is actually CUDA.

---

## Evaluation

**Classification — must include:**
- `classification_report` (precision, recall, F1 per class)
- Confusion matrix
- ROC-AUC if binary
- Note class imbalance impact on accuracy as a metric

**Regression — must include:**
- MAE, RMSE, R²
- Residual plot (predicted vs actual)
- Distribution of residuals

**All tasks:**
- Metrics computed on held-out test set, not training set
- Flag if only training metrics are shown
- Flag if val and test sets are conflated

---

## Matplotlib / plotting standards

### Figure setup — apply to every plot

```python
# Set once at the top of the visualisation section
mpl.rcParams.update({
    "figure.dpi":       150,
    "figure.facecolor": "white",
    "axes.spines.top":  False,
    "axes.spines.right":False,
    "axes.grid":        True,
    "grid.alpha":       0.3,
    "font.size":        12,
    "axes.titlesize":   14,
    "axes.labelsize":   12,
    "xtick.labelsize":  10,
    "ytick.labelsize":  10,
    "legend.fontsize":  10,
    "lines.linewidth":  2,
})
```

### Every plot must have:
- `fig, ax = plt.subplots(figsize=(...))` — never use pyplot stateful API for anything non-trivial
- `ax.set_title(...)` — descriptive, includes key parameter if relevant (e.g. "Training Loss — lr=0.001")
- `ax.set_xlabel(...)` and `ax.set_ylabel(...)` with units where applicable
- `plt.tight_layout()` before saving
- `fig.savefig(OUTPUT_DIR / "plot_name.png", dpi=150, bbox_inches="tight")` if outputs are being persisted

### Training curves

```python
fig, axes = plt.subplots(1, 2, figsize=(12, 4))

axes[0].plot(train_losses, label="Train")
axes[0].plot(val_losses,   label="Val")
axes[0].set_title("Loss")
axes[0].set_xlabel("Epoch")
axes[0].set_ylabel("Loss")
axes[0].legend()

axes[1].plot(train_accs, label="Train")
axes[1].plot(val_accs,   label="Val")
axes[1].set_title("Accuracy")
axes[1].set_xlabel("Epoch")
axes[1].set_ylabel("Accuracy")
axes[1].legend()

plt.tight_layout()
```

Flag: loss and accuracy plotted in the same axes on different scales without a twin axis, no legend when multiple series shown, epoch axis unlabelled.

### Confusion matrix

```python
from sklearn.metrics import ConfusionMatrixDisplay

fig, ax = plt.subplots(figsize=(8, 6))
ConfusionMatrixDisplay.from_predictions(
    y_true, y_pred,
    display_labels=CLASS_NAMES,
    cmap="Blues",
    ax=ax
)
ax.set_title("Confusion Matrix — Test Set")
plt.tight_layout()
```

Flag: raw `plt.imshow()` used for confusion matrix with manual tick labelling — error-prone and harder to read.

### Distribution plots
- Use `sns.histplot` with `kde=True` rather than `plt.hist` for continuous features
- Always set `color` explicitly — do not rely on default colour cycling for single-series plots
- For multi-class distributions, use `hue=` parameter rather than multiple separate plots

### Colormaps
- Sequential data: `"viridis"` or `"plasma"` (perceptually uniform, colourblind-safe)
- Diverging data (e.g. correlation matrix): `"coolwarm"` with `vmin=-1, vmax=1`
- Never use `"jet"` — flag it and replace

### Inline display
- `plt.show()` should appear once per logical plot group, not after every `ax` call
- In notebooks, `%matplotlib inline` or `%matplotlib widget` should be set once in the imports cell

---

## Cell hygiene

- Each cell should do one logical thing — flag cells that load data AND preprocess AND split
- Cell outputs should be clean: no full DataFrame prints (use `.head()`), no printing 1000-item lists
- Remove or comment dead cells (empty output, `pass`, old experiments left in)
- Markdown cells between major sections are required — not optional decoration
- `# %%` section markers are acceptable for IDE compatibility but should not replace Markdown headers

---

## Output format

Structure your analysis as follows. Be specific — cite the cell number or line.

```
## Summary
[2-3 sentences: overall quality, biggest issues, what's working well]

## Critical issues (fix before any other work)
- Cell N: [issue] — [why it matters] — [fix]

## Style & consistency issues
- Cell N: [issue] — [fix]

## Efficiency suggestions
- [suggestion] — Tradeoff: [what you gain] / [what you give up]
- Only suggest if relevant to the observed code — do not pad

## Plot improvements
- Cell N: [issue] — [fix]

## What's done well
- [genuine positives — do not fabricate these]
```

Do not produce a generic checklist. Every point must reference something actually present (or absent) in the notebook.