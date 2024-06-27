bring cloud;
bring expect;
bring vite;
bring http;
bring "./broadcaster.w" as broadcaster;

// Winglang doesn't have a built-in support for __dirname yet, so we use a workaround to get the current directory.
// @see tracking issue: https://github.com/winglang/wing/issues/3736
class Utils {
  extern "utils.js" pub static __dirname(): str;
}

let myBroadcaster = new broadcaster.Broadcaster() as "WebSocket";
let api = new cloud.Api(cors: true) as "WebService";
let counter = new cloud.Counter() as "KeyValueStore";

let website = new vite.Vite(
  root: "{Utils.__dirname()}/../frontend",
  publicEnv: {
    TITLE: "Wing + Vite + React",
    API_URL: api.url,
    WS_URL: myBroadcaster.url
  }
) as "Website"; 

api.get("/counter", inflight () => {
  return {
    body: "{counter.peek()}"
  };
});

api.post("/counter", inflight () => {
  let prev = counter.inc();
  myBroadcaster.broadcast("refresh");
  return {
    body: "{prev + 1}"
  };
});


