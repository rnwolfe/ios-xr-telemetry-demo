from kafka import KafkaConsumer
import json

KAFKA_TOPIC = 'pipeline'
KAFKA_BOOTSTRAP_SERVER = 'localhost:9092'

if __name__ == "__main__":
    bytes_received = {"MgmtEth0/RP0/CPU0/0": "UNKNOWN", "GigabitEthernet0/0/0/0": "UNKNOWN"}

    consumer = KafkaConsumer(KAFKA_TOPIC,
                                         bootstrap_servers=KAFKA_BOOTSTRAP_SERVER)
    for msg in consumer:
        telemetry_msg =  msg.value
        telemetry_msg_json = json.loads(telemetry_msg)

        # print json.dumps(telemetry_msg_json, indent=4)
        node_id = telemetry_msg_json["Telemetry"]["node_id_str"]

        if "Rows" in telemetry_msg_json:
            content_rows = telemetry_msg_json["Rows"]
            for row in content_rows:

                # Need this if in case we get telemetry data that's not for interface data, 
                # we will get a KeyError on the "interface-name" because other models will not have that value.
                if telemetry_msg_json["Telemetry"]["encoding_path"] == "Cisco-IOS-XR-infra-statsd-oper:infra-statistics/interfaces/interface/latest/generic-counters":
                    if row["Keys"]["interface-name"] == 'MgmtEth0/RP0/CPU0/0' or row["Keys"]["interface-name"] == 'GigabitEthernet0/0/0/0':
                        new_bytes_received = row["Content"]["bytes-received"]
                        if bytes_received[row["Keys"]["interface-name"]] != new_bytes_received:
                            print("\nBytes received on {3}:{4} changed from {0} to {1} at epoch time {2}".format(bytes_received[row["Keys"]["interface-name"]], new_bytes_received, row["Timestamp"], node_id, row["Keys"]["interface-name"]))
                            bytes_received[row["Keys"]["interface-name"]] = new_bytes_received
