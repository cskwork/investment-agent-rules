# 3. Demand a Margin of Safety

> "Confronted with the challenge to distill the secret of sound investment into three words, we venture the motto: MARGIN OF SAFETY."
> — Benjamin Graham, *The Intelligent Investor*

> "If you understand an idea, you can express it in no more than five words: 'always demand a margin of safety.'"
> — Warren Buffett

## Why

Estimates are wrong. Models are wrong. Inputs are stale. The future is unwritten.

Margin of safety is the gap between your estimate of intrinsic value and the price you pay. It is not optimism control; it is error control. It absorbs the part of the analysis that turns out to be wrong without turning the position into a permanent loss.

A thesis that is "very likely right" does not entitle the agent to pay any price. It entitles the agent to act when the asymmetry is paying for the model's own uncertainty.

The harder the inputs are to estimate — fast-changing industry, thin track record, regulatory dependence, single-customer concentration — the wider the margin must be. Confidence is not a substitute for a discount.

## Checklist

- [ ] Every entry has an explicit fair-value estimate (point or range), not just a peer multiple.
- [ ] Every entry has a required discount (e.g., `entry_price <= fair_value * (1 - margin_pct)`).
- [ ] The margin is bigger when the inputs are noisier (low liquidity, high volatility, thin history, cyclical earnings).
- [ ] Slippage, taxes, and fees are subtracted *before* checking the margin, not after.
- [ ] When no name clears the margin, the correct answer is "no purchase today" — not "lower the bar".
- [ ] The agent does not narrow the margin because the price has been rising.

## How an AI investment agent enforces this

```python
def passes_margin_of_safety(proposal, market):
    fv = proposal.fair_value
    sigma = proposal.fair_value_stddev       # the model's own uncertainty
    required_margin = max(0.20, 2 * sigma / fv)  # 20% floor; widen for noisier inputs
    entry = market.ask_with_slippage_and_tax()
    if entry > fv * (1 - required_margin):
        return Reject("entry_above_fair_value_minus_margin")
    return Allow()
```

Two failure modes this blocks:
1. Buying the "right" business at the wrong price.
2. Letting a confident-looking model talk the agent into ignoring its own error bars.
