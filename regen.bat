@echo off
setlocal
pushd %~dp0

set CODEGEN_TPLDIR=.\templates
set CODEGEN_OUTDIR=.\BusinessLogic
set RPSMFIL=.\rps\rpsmain.ism
set RPSTFIL=.\rps\rpstext.ism

codegen -e -t SynergyEnvironment                          -n BusinessLogic -r -lf
codegen -e -t ServicesCRUD -s PART SUPPLIER PRODUCT_GROUP -n BusinessLogic -r -lf

echo Code generation complete

popd
endlocal