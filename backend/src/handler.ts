import {KeyValueStore} from acme;

export const incrementCounter = async (event, context) => {
  let keyValueStore = KeyValueStore.of(context.keyValueStore);
  let counter = await keyValueStore.get("counter"); 
  await keyValueStore.set("counter", parseInt(counter) + 1);
}

export const getCounter = async (event, context) => {
  let keyValueStore = KeyValueStore.of(context.keyValueStore);
  return await keyValueStore.get("counter"); 
}
