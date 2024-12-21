export const WIREGUARD_CONNECTION_NAME: string = "wg-NL-FREE-150"

const vpn_status = Variable(false, {
  // every 5 minutes
  poll: [300_000, "sh -c \"nmcli connection show --active | grep wireguard\""],
});

export const VPN_ENABLED = vpn_status;

export const VPN_ENABLED_ICON = vpn_status.bind().as(on => `network-vpn${on ? '' : '-disabled'}-symbolic`);

export const VPN_ENABLED_TOGGLE = () => {
  // Utils.exec(`sh -c "bluetoothctl power ${vpn_status.value ? 'off' : 'on'}"`);
  Utils.exec(`sh -c "nmcli connection ${vpn_status.value ? 'down' : 'up'} ${WIREGUARD_CONNECTION_NAME}"`);
  vpn_status.value = !vpn_status.value;
}

export const SHOW_CONNECTIONS = () => Utils.execAsync(`kitty nmcli connection show`);
