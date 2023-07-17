document.addEventListener('turbolinks:load', () => {
  const accessTokenElement = document.getElementById('access_token');
  const accessToken = JSON.parse(accessTokenElement.textContent);
  mapboxgl.accessToken = accessToken;

  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/light-v10',
    center: [139.6917, 35.6895],
    zoom: 6,
  });

  map.on('load', () => {
    fetch('data/prefectures.geojson')
      .then(response => response.json())
      .then(data => {
        fetch('architecture.json')
          .then(response => response.json())
          .then(architecture => {
            const prefCounts = {};
            architecture.forEach(architecture => {
              const pref = architecture.pref;
              prefCounts[pref] = (prefCounts[pref] || 0) + 1;
            });

            const updatedFeatures = data.features.map(feature => {
              const prefCode = feature.properties.pref; // GeoJSONデータの都道府県コード
              const pref = getPrefectureName(prefCode); // 都道府県名に変換
              const count = prefCounts[pref] || 0;
              const color = count === 0 ? null : getCountColor(count);
              return {
                ...feature,
                properties: {
                  ...feature.properties,
                  'fill-color': color,
                  count: count,
                },
              };
            });

            map.addSource('prefectures', {
              type: 'geojson',
              data: {
                type: 'FeatureCollection',
                features: updatedFeatures.filter(feature => feature.properties['fill-color'] !== null),
              },
            });

            map.addLayer({
              id: 'prefectures-fill',
              type: 'fill',
              source: 'prefectures',
              paint: {
                'fill-color': ['get', 'fill-color'],
                'fill-opacity': 0.5,
              },
            });
          });
      });
  });

  // 都道府県コードから都道府県名を取得する関数
  function getPrefectureName(prefCode) {
    // 都道府県コードと都道府県名の対応表
    const prefectureMap = {
      1: '北海道',
      2: '青森県',
      3: '岩手県',
      4: '宮城県',
      5: '秋田県',
      6: '山形県',
      7: '福島県',
      8: '茨城県',
      9: '栃木県',
      10: '群馬県',
      11: '埼玉県',
      12: '千葉県',
      13: '東京都',
      14: '神奈川県',
      15: '新潟県',
      16: '富山県',
      17: '石川県',
      18: '福井県',
      19: '山梨県',
      20: '長野県',
      21: '岐阜県',
      22: '静岡県',
      23: '愛知県',
      24: '三重県',
      25: '滋賀県',
      26: '京都府',
      27: '大阪府',
      28: '兵庫県',
      29: '奈良県',
      30: '和歌山県',
      31: '鳥取県',
      32: '島根県',
      33: '岡山県',
      34: '広島県',
      35: '山口県',
      36: '徳島県',
      37: '香川県',
      38: '愛媛県',
      39: '高知県',
      40: '福岡県',
      41: '佐賀県',
      42: '長崎県',
      43: '熊本県',
      44: '大分県',
      45: '宮崎県',
      46: '鹿児島県',
      47: '沖縄県'
    };
    return prefectureMap[prefCode] || '';
  }

  // 建築の数に応じた色を返す関数
  function getCountColor(count) {
    if (count < 2) {
      return '#F3E766'; // 1件の場合は黄色
    } else if (count < 5) {
      return '#F4AA19'; // 2-4件の場合はオレンジ色
    } else if (count < 10) {
      return '#BC6548'; // 5-9件の場合は赤色
    } else {
      return '#0E3068'; // 10件以上の場合は青色
    }
  }
});
