import dbus
import dbus.mainloop.glib
# from gi.repository import GLib
from json import dumps

# https://pictogrammers.com/library/mdi/
locked = ["󰤬", "󰤡", "󰤤", "󰤧", "󰤪"]
open = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]

def get_security(ap_props):
    flags = ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'Flags')
    wpa_flags = ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'WpaFlags')
    rsn_flags = ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'RsnFlags')

    if wpa_flags or rsn_flags:
        return 'WPA/WPA2'
    elif flags & 0x1:
        return 'WEP'
    else:
        return 'Open'

def get_ordered_networks():
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
    bus = dbus.SystemBus()

    nm = bus.get_object('org.freedesktop.NetworkManager', '/org/freedesktop/NetworkManager')
    nm_iface = dbus.Interface(nm, 'org.freedesktop.NetworkManager')
    nm_props = dbus.Interface(nm, 'org.freedesktop.DBus.Properties')

    # Get active connection details
    active_connections = nm_props.Get('org.freedesktop.NetworkManager', 'ActiveConnections')
    active_ssid = None

    for ac_path in active_connections:
        ac_obj = bus.get_object('org.freedesktop.NetworkManager', ac_path)
        ac_props = dbus.Interface(ac_obj, 'org.freedesktop.DBus.Properties')

        try:
            devices = ac_props.Get('org.freedesktop.NetworkManager.Connection.Active', 'Devices')
            if not devices:
                continue

            device = devices[0]
            dev_obj = bus.get_object('org.freedesktop.NetworkManager', device)
            dev_iface = dbus.Interface(dev_obj, 'org.freedesktop.DBus.Properties')
            dev_type = dev_iface.Get('org.freedesktop.NetworkManager.Device', 'DeviceType')

            if dev_type == 2:  # Wi-Fi
                ap_path = dev_iface.Get('org.freedesktop.NetworkManager.Device.Wireless', 'ActiveAccessPoint')
                ap_obj = bus.get_object('org.freedesktop.NetworkManager', ap_path)
                ap_props = dbus.Interface(ap_obj, 'org.freedesktop.DBus.Properties')
                active_ssid = bytearray(ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'Ssid')).decode('utf-8', errors='replace')
        except dbus.exceptions.DBusException:
            continue

    devices = nm_iface.GetDevices()
    for dev_path in devices:
        dev_obj = bus.get_object('org.freedesktop.NetworkManager', dev_path)
        dev_props = dbus.Interface(dev_obj, 'org.freedesktop.DBus.Properties')
        dev_type = dev_props.Get('org.freedesktop.NetworkManager.Device', 'DeviceType')

        # 2 == Wi-Fi device
        if dev_type == 2:
            wifi_iface = dbus.Interface(dev_obj, 'org.freedesktop.NetworkManager.Device.Wireless')
            access_points = wifi_iface.GetAccessPoints()

            networks = []
            largest_ssid = 0
            for ap_path in access_points:
                ap_obj = bus.get_object('org.freedesktop.NetworkManager', ap_path)
                ap_props = dbus.Interface(ap_obj, 'org.freedesktop.DBus.Properties')
                security = get_security(ap_props)

                ssid = bytearray(ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'Ssid')).decode('utf-8', errors='replace')
                strength = ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'Strength')
                networks.append((ssid, strength, security))

            # Sort by strength, descending
            ordered = sorted(networks, key=lambda x: x[1], reverse=True)

            json = []
            ssids = set()
            for (ssid, strength, security) in ordered:
                if ssid in ssids:
                    continue
                checkbox = "*" if ssid == active_ssid else " "
                symbols = locked if security != "Open" else open
                json.append({
                    "checkbox": checkbox,
                    "ssid": ssid,
                    "symbol": symbols[min(int(strength / 20), 4)],
                    # "display": f'{checkbox} {ssid} {symbols[int(strength / 20)]} ',
                    })
                ssids.add(ssid)
            print(dumps(json))
            break  # only use the first Wi-Fi device

if __name__ == "__main__":
    get_ordered_networks()
