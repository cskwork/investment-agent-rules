# 7. Verify Management and Capital Allocation

> "When a management with a reputation for brilliance tackles a business with a reputation for bad economics, it is the reputation of the business that remains intact."
> — Warren Buffett

> "The job of the CEO is capital allocation."
> — Warren Buffett, paraphrased across many letters

## In short

The CEO decides what happens to the cash the business earns. A great business can be wrecked by a CEO who issues stock cheap, buys it back at peaks, takes on debt at the wrong time, or chases empire-building deals. Check the receipts before you trust them with your money.

## Why

A great business can still be destroyed by a CEO who issues new shares cheap, buys them back at the top, borrows at the top of the cycle, makes empire-building acquisitions, or treats minority shareholders as a piggy bank. The opposite is also true: an above-average business with a disciplined operator quietly compounds for decades.

The reason this gets its own rule, separate from "quality" (Rule 6), is that quality describes the *business*, and capital allocation describes the *use of the cash the business produces*. Two different variables — and the second is much easier for a single bad decision to wreck.

There are only five places earnings can go:

1. Reinvest into existing operations
2. Acquire something
3. Pay down debt
4. Pay dividends
5. Buy back stock

A good capital allocator picks among these *based on the return available at the time*, not based on what is fashionable. A bad allocator buys back stock at peaks and issues it at troughs — destroying value at both ends.

For an AI investment agent, this is the rule that separates "the spreadsheet looks great" from "the owners actually got the cash."

## Checklist

- [ ] Insider ownership is meaningful and aligned. Real skin in the game — not just options grants.
- [ ] Capital allocation history is examined across at least one full cycle.
- [ ] **Buybacks**: are they done at sensible valuations, or only when the stock is high and the CEO's bonus depends on it?
- [ ] **Acquisitions**: how have past deals actually performed (returns, write-downs, integration outcomes)?
- [ ] **Debt**: used opportunistically at sensible terms, or stretched at the wrong point in the cycle?
- [ ] **Share count**: stable or shrinking? Persistent dilution without matching value creation is a red flag.
- [ ] **Management communication**: does the shareholder letter explain *why* the cash went where it did, or is it marketing copy?

## How an AI investment agent enforces this

```python
def passes_management_test(proposal):
    m = proposal.management_assessment
    if m.insider_ownership_pct < 0.01 and not m.has_aligned_compensation:
        return Reject("no_skin_in_the_game")
    if m.share_count_5yr_change > 0.10 and not m.justified_by_value_creation:
        return Reject("persistent_dilution_without_value")
    if m.acquisition_track_record_irr is not None and m.acquisition_track_record_irr < m.cost_of_capital:
        return Reject("value_destroying_acquisitions")
    if m.buyback_price_to_value_ratio_avg > 1.0:
        return Reject("buybacks_above_intrinsic_value")
    if not m.shareholder_letter_is_substantive:
        return Reject("opaque_capital_allocation_communication")
    return Allow()
```

The business produces the cash. Management decides what happens to it. Both votes count.
