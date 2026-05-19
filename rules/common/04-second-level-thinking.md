# 4. Second-Level Thinking

> "First-level thinking says, 'It's a good company; let's buy the stock.' Second-level thinking says, 'It's a good company, but everyone thinks it's a great company, and it's not. So the stock's overrated and overpriced; let's sell.'"
> — Howard Marks, *The Most Important Thing*

> "Invert, always invert."
> — Charlie Munger (channeling Jacobi)

## Why

The consensus view is already in the price. Trading on it is trading on information that has zero edge.

Edge lives in the gap between what is true and what the market currently believes. To find that gap you have to ask the second question: *given that everyone can see what I see, why is the price still here?*

Munger's inversion is the operational version of the same idea: don't ask "how do I win this trade?" — ask "how would this trade kill me?" — and refuse to take it unless you have an answer.

## Checklist

- [ ] Every entry has a written thesis explaining what the market is mispricing and why.
- [ ] The thesis names the consensus view explicitly (analyst price target, news sentiment, retail flow).
- [ ] An inversion section answers: "what would have to be true for this thesis to be wrong?" — and the bot can detect that condition in market data.
- [ ] When the signal aligns 100% with consensus and momentum, the bot at least asks whether it is buying the obvious — and either documents the edge or stands down.
- [ ] Crowded trades trigger a position-size haircut.

## How an AI trading bot enforces this

```python
def edge_check(signal, consensus):
    # signal.direction ∈ {long, short}; consensus.direction same domain
    if signal.direction == consensus.direction and consensus.strength > 0.8:
        # Same side as a strong consensus → require extra edge
        if signal.expected_return < 2 * consensus.priced_in_return:
            return Reject("no second-level edge over consensus")
    # Inversion gate
    if signal.invalidation_condition is None:
        return Reject("no invalidation written — cannot inversion-test")
    return Allow()
```

If the bot cannot articulate why the consensus is wrong, the bot is the consensus.
