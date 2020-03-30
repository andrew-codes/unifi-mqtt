Unifi Access Point Association MQTT Binding
=======

The Lock status will be polled at a user-defined interval and published to the topic as well as printed to the console.

```json
{
  "mac": "b8:e8:56:44:62:10",
  "type": "appear",
  "hostname": "laptop"
}
```

Run as Docker container
-----------

```shell
docker run --name salanki/unifi-mqtt --restart=always -t -e UNIFI_PASSWORD=mypass -e UNIFI_USERNAME=user -e UNIFI_HOST=192.168.15.9 -e MQTT_BROKER=192.168.15.9 -e MQTT_TOPIC=home/wifi/presence unif
```

Usage with OpenHAB
-----------

Simply use the `MQTT Binding <http://docs.openhab.org/addons/bindings/mqtt1/readme.html>`_. A custom `transform/unifipresence.js` is required.

```js
(function(i) {
  var json = JSON.parse(i);
  if (json.type == 'appear') {
    return 'ON';
  } else {
    return 'OFF';
  }
})(input)
```

```
Group:Switch:OR(ON, OFF) Presence "At home [%d]" <presence>
Group:Switch:OR(ON, OFF) Presence_Peter "Peter [%d]" <man_2> (Presence)
Group:Switch:OR(ON, OFF) Presence_Erika "Erika [%d]" <woman_2> (Presence)

Switch Presence_Peter_Unifi "Peter iPhone WiFi [%s]" (Presence_Peter) { mqtt="<[local:home/wifi/presence:state:JS(unifipresence.js):.*peteri-X.*" }
Switch Presence_Erika_Unifi "Erika iPhone WiFi [%s]" (Presence_Erika) { mqtt="<[local:home/wifi/presence:state:JS(unifipresence.js):.*erika-Phone.*"
```
