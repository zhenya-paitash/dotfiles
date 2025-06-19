const bluetooth_power = Variable(false, {
  // every 5 minutes
  poll: [300_000, "sh -c \"bluetoothctl show | grep 'Powered: ' | awk '{print \$2}'\"", out => out === 'yes'],
});

export const BLUETOOTH_POWER = bluetooth_power;

export const BLUETOOTH_POWER_ICON = bluetooth_power.bind().as(on => `bluetooth-${on ? 'active' : 'disabled'}-symbolic`);

export const BLUETOOTH_POWER_TOGGLE = () => {
  Utils.exec(`sh -c "bluetoothctl power ${bluetooth_power.value ? 'off' : 'on'}"`);
  bluetooth_power.value = !bluetooth_power.value;
}

export const BLUETOOTH_POWER_OPEN = () => {
  // RUN: open terminal with bluetooth util
  // Utils.execAsync(`kitty bluetoothctl`);
  Utils.execAsync(`blueman-manager`);
}
