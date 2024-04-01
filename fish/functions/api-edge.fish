begin
  set -lx USE_LOCAL_EDGE 1 
  set -lx METRICS_PORT 8181
  script/server
end
