# 7. Concentration in Conviction, Diversification in Ignorance

> "Diversification is a protection against ignorance. It makes very little sense for those who know what they're doing."
> — Warren Buffett

> "I believe the Holy Grail of investing is to have 15 or more good, uncorrelated return streams."
> — Ray Dalio

## Why

Both statements are true at the same time. They describe different parts of the operator's life.

Where you have *real* edge — verified, repeatable, sized — concentrate. The edge is rare; spreading it thin throws it away.

Where you don't have edge — most asset classes, most timeframes, most regimes — diversify. Not into 50 correlated stocks, but into genuinely uncorrelated return streams. The mathematics is in the correlation matrix, not the position count.

The failure mode an AI agent falls into easily: *fake diversification*. 30 names that all rip on the same beta factor are one bet wearing a costume.

## Checklist

- [ ] Each "strategy" has a documented edge and a separate risk budget.
- [ ] Position counts are an output of correlation, not a target ("we hold 20 names" is not a strategy).
- [ ] The bot tracks pairwise correlation of open positions; when median correlation crosses a threshold (e.g., 0.7), gross exposure is capped.
- [ ] Factor exposure (beta, sector, momentum, value) is monitored separately from name exposure.
- [ ] Concentration is allowed only where the strategy has earned it (out-of-sample track record, not backtest hope).

## How an AI trading bot enforces this

```python
def gross_cap_for_book(open_positions):
    if len(open_positions) < 2:
        return 1.0   # no correlation problem yet
    rho = median_pairwise_correlation(open_positions, lookback_days=60)
    if rho > 0.7:
        return 0.5   # halve gross — your "diversification" is fake
    if rho > 0.4:
        return 0.75
    return 1.0

def conviction_concentration_ok(strategy_stats, position_weight):
    # only allow >10% single-name weight if the strategy has proven OOS
    if position_weight <= 0.10:
        return True
    return (strategy_stats.live_sharpe_oos > 1.0
            and strategy_stats.months_live >= 12)
```

Concentrate where you have earned it. Diversify everywhere else. Never confuse the two.
