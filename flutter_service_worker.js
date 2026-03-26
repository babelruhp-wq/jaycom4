'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "9564e07fc843cc8046a13f8caf9c58b4",
".git/config": "5f809b3b045aa7c5300539ffce0d6edf",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "aa897937d98292293b0e985efaf071f9",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "c03a4519f7b2556f1c22a328f7a90206",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "83941507051fd08368e355d68afc597c",
".git/logs/refs/heads/main": "435d60d0339bf4e824dd86ab2b30c95a",
".git/logs/refs/remotes/origin/HEAD": "496959a67f65b5d983e3b6a957675b18",
".git/logs/refs/remotes/origin/main": "2d08e96475a74d135374f4113e436f74",
".git/objects/00/398780528ee088ec3b2aa82c4e2b116cc9933f": "d3688c0b6f9501ba37d58ac580c0698c",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/0f/bfa3934716bc35e668a1c5aea9462a33d644b6": "207651e35b8f7a61f221b6381268568b",
".git/objects/10/2d8a8f4c4d115b4ade124ea221f6aee851bb42": "e611f3aada09058374565b13ada94891",
".git/objects/11/11800be7c35824b3cb93a34e311300a45d74fc": "3a4c7da335123c3c9ca3d6c0754a7fab",
".git/objects/16/2ddd040a978914f3783fdfb76f48c46b6b7363": "b46467e64a540beb11c7a82497761272",
".git/objects/17/813897f8d7d3354dc788c3344d0849de68466b": "715dda0692459bfff312fe42ab79e7c6",
".git/objects/20/1eeb0e7e49a1f5230032712bf396367b4deb1e": "a4644404effc2dff7541937b1b202e69",
".git/objects/25/307ff536d30d536dfc4bb98f9764c119c2fdb9": "a8f6cc1d37040f25c7ed4874bcd48323",
".git/objects/29/68012f355e6dd99260630798d5aa2c82add6c9": "a761acae650b263d5b285821efaa4b58",
".git/objects/2a/4f48a6644cc14c64b2c0ee5bc649bbad2c1dda": "773f6785b6e180d3821b364d1c68587f",
".git/objects/2a/a2f8bfb68ef5c502b7dc2bb495ba3e17fc8bb0": "4530f358566e3f33761c59b41df39ef9",
".git/objects/2d/956ed8d577e874ae1b8c50fa62caa1eea9bf96": "3a640f8511699c1eb2bc9e2a881670f4",
".git/objects/34/ca7b643ad33bff17c49511fc4c3912a06ae601": "76500ee8a41fbe98db2754645d3d6b71",
".git/objects/3a/4fd20204c4b5fa9b7112e70803f1afda700ec0": "ca25bd0b02b34c6cc53ff9141fcef073",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/3f/995c7bbea6684f051a76365a798e13bb4749ee": "0634bb843b0fae003a3ee54d691bb1c9",
".git/objects/4f/40dabe4430b4d7288c6ae92d8fc3e17cf8e410": "7c1843130f2c3787540ded5445c7793a",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/52/934e6f0edd24451e4c39629eb66605f2083604": "944b32ccad83abd3bd6134aae78a55a1",
".git/objects/5e/60dac133eee2050aebeaf0262a5f6164ba7ad1": "9512682cd765929e9ac353dc69f91cc6",
".git/objects/67/9e5b17ddf25b9463e826f4e1389fd35187dc64": "e75d74d18931c7511fc555d0f139bbf2",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/70/2ce995a0300b1d96c127bba064d9cb276555de": "d2cac267998be28f0ccfa6281d19e098",
".git/objects/71/a4f92820ff21184e761c86846a32f44d01e571": "b21c1c36a4f608385b42346f47d3f8c8",
".git/objects/75/66c2fdc9e8484ce6679b91d7a4f99462e76d91": "945d38036e839cf81556395b3835fe11",
".git/objects/7b/786ce432703e651f0e86da9d43bcf65ed63f9a": "08a816ebcd2dedf83db8afd8365f9684",
".git/objects/7b/cefa285b14a2dae13e6af22b76b94a24d19c42": "58971f75a030ff648cbe8cf5af1b0796",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/82/039646eae58381941a128edf3dd254c98a2961": "ba71a4099c57c699fe2ac9b609735b8e",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/283a72e14ca52c989046f1eff75e9c885bcf06": "552772c4d04f4790480f045db1969306",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/21753cdb204192a414b235db41da6a8446c8b4": "1e467e19cabb5d3d38b8fe200c37479e",
".git/objects/91/da401c288df118fb050ae52732f452ed971254": "c3a2828cedd9ab13403d3fec5d8b0a2a",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/96/4cb7b943a13bf072dbea4a670c792c11c059b1": "84cf83f18aa2fb495c5a1cb2e879bc6d",
".git/objects/97/70ea8890d76cd146d3507d39e3aca6360f8d6c": "16f36beeef99d8d4cdec85b78c8bad70",
".git/objects/99/2560270dc5f8e2c25958a23245936ea7a1a4b5": "2d4e484a295681f3fb0573fe5d884e76",
".git/objects/9b/43e3f50abfb0d4d5ac19c4d916acb059a1b030": "d5dc5821d2be176ad54196ccfa46711d",
".git/objects/a2/d38cfea5c538f9d6a5c4088049d8501b8828ce": "729e414300bea235488fd1e52944833b",
".git/objects/a7/3f4b23dde68ce5a05ce4c658ccd690c7f707ec": "ee275830276a88bac752feff80ed6470",
".git/objects/ac/777735cd9cce12b0953aa1c3b24d7ad7a0530b": "2ed6cfd6e641e1c1932b367b20eedfaa",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/b0/939317d99b74bf2cd5de8ed131e2a6b43bfdf0": "9a9ab79bad6794f0b7bc259558db1357",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/ba/bb6f2676ec02404ed92d4a0b9035188172b203": "e4734ae7c8675d212e8fb86aa9d34af8",
".git/objects/c4/371382dd4af2fc3464f5eb9a701a1c7fce0b73": "753008df31c1d9b75c6304af11ef58db",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/cf/1a0b2308178458fe9b0a7ab49f3f8a0730c7bd": "f25abe9de455e808e86c63158432a685",
".git/objects/cf/9bbbc74bf7d3612856a793f2e59ba8fe55bef5": "38809ae623b448f9b56741375287e0fb",
".git/objects/d1/8570eaa08ff7d20e253b05bdb572f8cb3d66d4": "80f41f1597a8a2c91b9e7a9fdbe90423",
".git/objects/d1/e6b91480da45e3f35ffeeb7ef4b060b06fb506": "50a699482d79fed7d57867af0e7d6520",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d4/d958df5d6ea9ee98deb534cec06c874d3c19e3": "6acb1418994b03c8a1ccba1f83e9e097",
".git/objects/d4/e40b93ee8d76cb77baa4b1e91e6e3ed9591c75": "e983b38bc20a105e76db60600e773d35",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d8/b85a47f300846f17aa13a02a2cfa19c9bc2189": "2a22290ef7f25380fa0dd39c8002b833",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/e6/dfc32f5882c10c92276d28bee3e1a077d88ad7": "17e781cdc5907d11282303707d905af4",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/374c24778dee7ea760ded0fc0ef7f0b577242f": "1aaa1ecaa31085d3e0867293879468ad",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/eb/f59fc62a4792b502363b4e924c6a3a1362d70f": "5779689eb3e1a7194dd06a792f542f67",
".git/objects/eb/fb89d7ec7df6a9a59b24425e482260e7267911": "fa4ffcb5ea52cca27d09871e277969f8",
".git/objects/ed/d990a6b4a972cc2a0a4df30efc171244d37fe2": "404db3c3f07afc16a33b1b586b253d95",
".git/objects/f1/505772b1135901e9ed9285bba54857c7182098": "568af98e558b63a38dbc3b6a318f5613",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/f5/43db6ef0e4cbb6e71a7d25d8e711861f5adbea": "30bdb315f3d9705934ecabf9e0314fcb",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/fc/562bcaad5f3c2ca3e739f93564d9b7e8717de5": "d90d4801cb7314c702f4d1dafa4e3ff5",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/refs/heads/main": "b845d551462bd617f8ab7f9a7080fb78",
".git/refs/remotes/origin/HEAD": "98b16e0b650190870f1b40bc8f4aec4e",
".git/refs/remotes/origin/main": "b845d551462bd617f8ab7f9a7080fb78",
"assets/AssetManifest.bin": "2757ac48e59e0a578cc245bd16a7aba3",
"assets/AssetManifest.bin.json": "869ab890f042936388e41cb97c70870b",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "dd6c3592318e7c035ace94a3d5c5a27e",
"assets/NOTICES": "56c61f8977d077194e2cf756318bee01",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "d234accf861c9cc127dec3b57da47251",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "b2703f18eee8303425a5342dba6958db",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "5b8d20acec3e57711717f61417c1be44",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "a51d179b6df9761f1d10e4f9cb3f4796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "1a53ae518a6b326dddd12bf8ccad9886",
"/": "1a53ae518a6b326dddd12bf8ccad9886",
"main.dart.js": "adae874380f3da7135cd499ac728e8ad",
"manifest.json": "186d5a6e2b6e8a850d68c4dce0df2429",
"version.json": "0309d0a717bd88de2331b910a48f1883"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
