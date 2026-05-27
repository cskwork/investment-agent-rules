# 3. Demand a Margin of Safety

> "Confronted with the challenge to distill the secret of sound investment into three words, we venture the motto: MARGIN OF SAFETY."
> — Benjamin Graham, *The Intelligent Investor*

> "If you understand an idea, you can express it in no more than five words: 'always demand a margin of safety.'"
> — Warren Buffett

## In short

Pay enough below what you think a business is worth that even if you turn out to be wrong by 20–30%, you still don't get hurt. The less certain you are, the bigger that gap has to be.

## Why

Your numbers will be wrong. Your model will be wrong. The information you used will be a little out of date. The future will look different from anything you imagined.

Margin of safety is the gap between your estimate of what the business is worth and the price you actually pay. It is not optimism; it is *error control*. The gap absorbs the part of your analysis that turns out to be wrong, without that mistake becoming a permanent loss.

"I am pretty confident in this thesis" does not give the agent permission to pay any price. It gives the agent permission to act *when the discount is big enough to absorb the model's own uncertainty*.

The noisier the inputs, the wider the margin must be. Fast-changing industry, short track record, dependent on one regulator, dependent on one customer — all of these reasons require a larger gap, because there is more room for the estimate to be wrong.

Confidence is not a substitute for a discount.

## Checklist

- [ ] Every position has a clear estimate of fair value (a number or a range) — not just a multiple borrowed from peers.
- [ ] Every position has a required discount in writing (for example, "I only buy if the price is at least 20% below my estimate").
- [ ] The discount is bigger when the inputs are less reliable (illiquid, short history, cyclical earnings, single big customer).
- [ ] Trading fees, taxes, and slippage are subtracted *before* checking the discount, not after.
- [ ] When nothing meets the margin, the right answer is "no purchase today" — not "lower the bar".
- [ ] The agent does not shrink the margin because the price has been rising.

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
1. Buying the right business at the wrong price.
2. Letting a confident-sounding model talk the agent into ignoring its own error bars.
