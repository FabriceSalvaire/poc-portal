# 1

mkdir root
git mv ... root/

git subtree split -P root -b root
git subtree split -P portal-frontend -b frontend
git subtree split -P basic-checkout-frontend -b checkout-frontend
git subtree split -P backend -b backend

git remote add poc-portal-checkout-frontend  git@code.electrolab.fr:fabrice/poc-portal-checkout-frontend.git
git remote add poc-portal-frontend git@code.electrolab.fr:fabrice/poc-portal-frontend.git
git remote add poc-portal-backend git@code.electrolab.fr:fabrice/poc-portal-backend.git
git remote add poc-portal git@code.electrolab.fr:fabrice/poc-portal.git

git push poc-portal root
git push poc-portal-backend backend
git push poc-portal-checkout-frontend checkout-frontend
git push poc-portal-frontend frontend

# 2

git clone git@code.electrolab.fr:fabrice/poc-portal.git

git submodule add git@code.electrolab.fr:fabrice/poc-portal-backend.git
git submodule add git@code.electrolab.fr:fabrice/poc-portal-frontend.git
git submodule add git@code.electrolab.fr:fabrice/poc-portal-checkout-frontend.git
