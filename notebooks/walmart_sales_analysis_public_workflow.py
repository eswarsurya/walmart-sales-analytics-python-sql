"""Public Walmart sales analytics workflow.

This script uses the public sample data and shows the Python analysis structure
behind the project without relying on the full local notebook.
"""

import pandas as pd

DATA_PATH = "../data/public_sample_walmart_sales.csv"


def load_sales(path=DATA_PATH):
    sales = pd.read_csv(path, parse_dates=["Date"])
    sales["Year"] = sales["Date"].dt.year
    return sales


def sales_by_store(sales):
    return (
        sales.groupby("Store", as_index=False)["Weekly_Sales"]
        .sum()
        .sort_values("Weekly_Sales", ascending=False)
    )


def holiday_sales_comparison(sales):
    return sales.groupby("Holiday_Flag")["Weekly_Sales"].agg(["count", "mean", "sum"])


if __name__ == "__main__":
    walmart_sales = load_sales()
    print("Records reviewed:", len(walmart_sales))
    print("Stores in sample:", walmart_sales["Store"].nunique())
    print("Top stores by sales:")
    print(sales_by_store(walmart_sales).head())
    print("Holiday comparison:")
    print(holiday_sales_comparison(walmart_sales))
