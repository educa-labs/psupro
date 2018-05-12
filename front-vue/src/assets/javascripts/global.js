global.get = (obj, key) => {
  return key.split('.').reduce((o, x) => {
    return typeof o === 'undefined' || o === null ? o : o[x];
  }, obj);
};

global.put = console.log;
