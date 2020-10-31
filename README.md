# Proof of Concept Portal

**Backend Stack**

```
Backend : [ Nginx HTTP proxy <-> Gunicorn * [Uvicorn ASGI] @ Python 3.7 > FastAPI -> PostgreSQL ]

    <--- HTTP JSON XHR / REST API --->

Browser > Web Frontend
```

* [FastAPI](https://fastapi.tiangolo.com) Web Framework to build REST server

 **key features:**
 - fast and competitive
 - asynchronous I/O event loop using [libuv](https://github.com/libuv/libuv)
 - support [OpenAPI](https://github.com/OAI/OpenAPI-Specification) / [JSON Schema](http://json-schema.org)
 - generate automatic interactive documentation
 - load JSON to class object and verify schema
 - support [GraphQL](https://graphql.org)

* [Starlette](https://github.com/encode/starlette) ASGI framework/toolkit
* [Uvicorn](https://www.uvicorn.org) ASGI server as [Gunicorn](https://gunicorn.org) worker
* [SqlAlchemy](https://www.sqlalchemy.org) ORM -> [PostgreSQL](https://www.postgresql.org)
* [MJML](https://mjml.io) Responsive Email Framework

**Checkout Frontend Stack**

* [React](https://reactjs.org)
* [Create React App](https://create-react-app.dev) (using Webpack)
* Sass stylesheet
* Nginx HTTP proxy or as a Wordpress Plugin

**Checkout Frontend Stack**

* [React](https://reactjs.org) Web Framework
* [React Router](https://reactrouter.com)
* [Redux](https://redux.js.org)
* transpiled and bundled by [Webpack](https://webpack.js.org)
* Sass stylesheet
* Nginx HTTP proxy

# Screenshots

https://code.electrolab.fr/fabrice/poc-portal/-/tree/master/screenshots

## OpenAPI Swagger Documentation
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.49.37-fullpage.png "OpenAPI Swagger Documentation")
## Create Donation
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.50.06-fullpage.png "Create donation")

## Frontend Form
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Screenshot_20201026_175042.png "Frontend form")
## Stripe Checkout
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.54.01-fullpage.png "Stripe Checkout")
## Stripe Payments
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.55.18-fullpage.png "Stripe payments")
## Stripe Payment
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.55.29-fullpage.png "Stripe payment")
## Redirect to Frontend after Stripe Checkout Completed
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Screenshot_20201026_175429.png "redirect to Frontend after Stripe checkout completed")

## OAuth2 Login in OpenAPI
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.56.52-fullpage.png "OAuth2 login")
# OAuth2 logged
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.56.57-fullpage.png "OAuth2 bearer")
# Donations Query
![](https://code.electrolab.fr/fabrice/poc-portal/-/raw/master/screenshots/Capture%20d%E2%80%99%C3%A9cran%202020-10-26%20%C3%A0%2017.57.12-fullpage.png "Donations query")

# Urls

* Backend OpenAPI : http://localtest.me:8000/docs
* Frontend: http://localhost:3000/checkout

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
