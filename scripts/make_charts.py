"""Draws the summary charts used in the report.

The numbers are the results of the queries in sql/04_analysis_queries.sql.
Run from the project folder:  python scripts/make_charts.py
Requires matplotlib.
"""
import os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

OUT = os.path.join(os.path.dirname(__file__), "..", "images")
BLUE = "#2f6fb0"
INK = "#222222"
MUTED = "#666666"


def bar_chart(filename, title, subtitle, labels, values, fmt="{:.0f}", xlabel=""):
    fig, ax = plt.subplots(figsize=(8, 4.5), dpi=150)
    bars = ax.bar(labels, values, color=BLUE, width=0.55)
    for b, v in zip(bars, values):
        va = "bottom" if v >= 0 else "top"
        off = 3 if v >= 0 else -3
        ax.annotate(fmt.format(v), (b.get_x() + b.get_width() / 2, v),
                    xytext=(0, off), textcoords="offset points",
                    ha="center", va=va, fontsize=11, color=INK)
    for side in ("top", "right", "left"):
        ax.spines[side].set_visible(False)
    ax.spines["bottom"].set_color("#bbbbbb")
    ax.axhline(0, color="#bbbbbb", linewidth=1)
    ax.yaxis.grid(True, color="#e6e6e6", linewidth=1)
    ax.set_axisbelow(True)
    ax.tick_params(axis="both", length=0, labelsize=10, colors=MUTED)
    ax.set_xlabel(xlabel, fontsize=10, color=MUTED)
    lo, hi = min(values + [0]), max(values)
    pad = (hi - lo) * 0.12
    ax.set_ylim(lo - (pad if lo < 0 else 0), hi + pad)
    fig.suptitle(title, x=0.06, y=0.97, ha="left", fontsize=14,
                 fontweight="bold", color=INK)
    ax.set_title(subtitle, loc="left", fontsize=10, color=MUTED, pad=12)
    fig.tight_layout(rect=(0.02, 0, 1, 0.95))
    fig.savefig(os.path.join(OUT, filename), facecolor="white")
    plt.close(fig)


bar_chart("chart_failures_by_component.png",
          "Component 2 fails most often",
          "Number of failures by component, all 100 machines, 2015",
          ["comp1", "comp2", "comp3", "comp4"], [192, 259, 131, 179])

bar_chart("chart_failures_by_model.png",
          "Model 1 fails about twice as often as model 4",
          "Average failures per machine in 2015, by machine model",
          ["model1", "model2", "model3", "model4"],
          [11.81, 9.88, 6.31, 5.72], fmt="{:.2f}")

bar_chart("chart_failures_by_age.png",
          "Failures step up after ten years of age",
          "Average failures per machine in 2015, by machine age group",
          ["0-5 years", "6-10 years", "11-15 years", "16-20 years"],
          [5.90, 5.38, 9.21, 9.52], fmt="{:.2f}")

normal = {"Voltage": 170.78, "Rotation": 446.61, "Pressure": 100.86, "Vibration": 40.39}
before = {"Voltage": 176.16, "Rotation": 417.20, "Pressure": 105.57, "Vibration": 42.91}
change = [round((before[k] - normal[k]) / normal[k] * 100, 1) for k in normal]
bar_chart("chart_sensors_before_failure.png",
          "Rotation drops and the other sensors rise before a failure",
          "Change in the average reading during the 24 hours before a failure, "
          "compared with all readings (%)",
          list(normal), change, fmt="{:+.1f}%")
