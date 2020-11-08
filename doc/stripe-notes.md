# Stripe Test Card

| Type               | Issuer    | Payment  | ID                  |
| ------------------ | --------- | -------- | --------------------|
| French Visa        | Stripe.uk | succeeds | 4000 0025 0000 0003 |
| International Visa | Stripe.us | succeeds | 4242 4242 4242 4242 |
| International Visa | Stripe.us | declined | 4000 0025 0000 3155 |

# Stripe Fee Computation

```
P = N + 0.25 + N*f
  = N*(1+f) + 0.25

N = (P - 0.25) / (1 + f)

10*(1+1.4/100) + 0.25 = + 0.39
100                   = + 1.65
500                   = + 7.25
```
