import dagster as dg 

@dg.asset(key=dg.AssetKey(["test"]))
def orders():
    """A simple orders asset."""
    return {"orders": []}