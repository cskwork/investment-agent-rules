# 2. Margin of Safety

> "Confronted with the challenge to distill the secret of sound investment into three words, we venture the motto: MARGIN OF SAFETY."
> — Benjamin Graham, *The Intelligent Investor*

> "If you understand an idea, you can express it in no more than five words: 'always demand a margin of safety.'"
> — Warren Buffett

## Why

Estimates are wrong. Models are wrong. Inputs are stale. The future is unwritten.

Margin of safety is the gap between your estimate of intrinsic value and the price you pay. It is not optimism control; it is error control. It absorbs the part of the analysis that turns out to be wrong without turning the position into a permanent loss.

A signal with a 0.55 win rate does not entitle the agent to enter at any price. It entitles the agent to enter when the asymmetry is paying for the model's own uncertainty.

## Checklist

- [ ] Every entry has an explicit fair value or expected-value estimate (point or range).
- [ ] Every entry has a required discount (e.g., `entry_price <= fair_value * (1 - margin_pct)`).
- [ ] The margin is bigger when the inputs are noisier (low liquidity, high volatility, thin history).
- [ ] Slippage and fees are subtracted *before* checking the margin, not after.
- [ ] When no name clears the margin, the correct answer is "no trade today" — not "lower the bar".

## How an AI trading bot enforces this

```python
def passes_margin_of_safety(signal, market):
    fv = signal.fair_value_krw           # point estimate
    sigma = signal.fair_value_stddev     # model's own uncertainty
    required_margin = max(0.10, 2 * sigma / fv)  # 10% floor, 2-sigma scaling
    entry = market.ask_with_slippage_and_tax()
    return entry <= fv * (1 - required_margin)
```

Two failure modes this blocks:
1. Buying the "right" company at the wrong price.
2. Letting a confident-looking model talk the bot into ignoring its own error bars.
