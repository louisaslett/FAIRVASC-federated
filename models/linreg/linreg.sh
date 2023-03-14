#!/bin/bash

# Note, the two linreg JavaScript functions differ only in function name (so
# that we can verify the computation is done locally and result transmitted,
# as opposed to input transmitted and computation done centrally)
diff linreg_xtx_xty.js linreg_xtx_xty_slave.js

# Launch containers running Fuseki SPARQL server to replicate a distributed
# environment
# NOTE: run each of these in a separate terminal so that the output can be 
# viewed
docker run -it --rm -p "3030:3030" --name reg1 \
    -v $(pwd)/linreg_xtx_xty.js:/jsfuncs.js \
    ghcr.io/louisaslett/fairvasc_fuseki:latest --update \
    --set arq:js-library=/jsfuncs.js --mem /fv
docker run -it --rm -p "3031:3030" --name reg2 \
    -v $(pwd)/linreg_xtx_xty.js:/jsfuncs.js \
    ghcr.io/louisaslett/fairvasc_fuseki:latest --update \
    --set arq:js-library=/jsfuncs.js --mem /fv
docker run -it --rm -p "3032:3030" --name reg3 \
    -v $(pwd)/linreg_xtx_xty.js:/jsfuncs.js \
    ghcr.io/louisaslett/fairvasc_fuseki:latest --update \
    --set arq:js-library=/jsfuncs.js --mem /fv

# Generate data which exhibits Simpson's paradox, so we can easily see different
# local and global regressions
Rscript GenData.R

# Make data into a SPARQL update query
for reg in reg*.n3; do
  echo 'update=insert data {' | cat - $reg > temp && mv temp $reg
  echo '}' >> $reg
done

# Upload data thru SPARQL update query
r=3030
for reg in reg*.n3; do
  curl -X POST -d @$reg localhost:$r/fv/update
  ((r++))
done

# Query data to confirm loaded
r=3030
for reg in reg*.n3; do
  echo "## => REGISTRY $((r-3029)) <= ##"
  curl -X POST -d "query=SELECT ?s ?p ?o WHERE { ?s ?p ?o . }" localhost:$r/fv/query
  ((r++))
done

curl -X POST -d @rqs/regLR_1_xtx_xty.rq localhost:3030/fv/query
curl -X POST -d @rqs/regLR_1_xtx_xty_slave.rq localhost:3031/fv/query
curl -X POST -d @rqs/regLR_1_xtx_xty_slave.rq localhost:3032/fv/query
curl -X POST -d @rqs/regLR_1_fin.rq localhost:3030/fv/query
curl -X POST -d @rqs/regLR_1_fin_slave.rq localhost:3031/fv/query
curl -X POST -d @rqs/regLR_1_fin_slave.rq localhost:3032/fv/query
curl -X POST -d @rqs/regLR_all_xtx_xty.rq localhost:3030/fv/query
curl -X POST -d @rqs/regLR_all_fin.rq localhost:3030/fv/query
