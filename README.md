# Create Windows Server GZ Image Using QEMU
Create Windows Server GZ Image using Qemu on any KVM or Virtualization Enabled VPS

**This project is a bash script that help you to fast the process and make it easy to run commands to install qemu and make image for the installation!**

## Contribution
Contributions, bug reports, and feature requests are welcome! Feel free to explore the issues section for ongoing development and planned features. For additional assistance, consider checking out the discussions.

## Usage
Follow these steps to get started

**Only Works with Ubuntu & Debian (Tested with Ubuntu 22.04, 20.04)**

1- Run this Command 
```bash
curl -O https://raw.githubusercontent.com/UncutDevs/create-windows-gz-using-qemu/main/server-setup.sh
chmod +x setup-server.sh
./setup-server.sh
```

## Manual Command Section
2- Once the Above Downloads are done then You will have to manual run this command
** You can adjust the memoery "-m 4G' to desire amount if you have more RAM available  **

```bash
qemu-system-x86_64 \
  -m 4G \
  -cpu host \
  -enable-kvm \
  -boot order=d \
  -drive file=windows.iso,media=cdrom \
  -drive file=windows.img,format=raw,if=virtio \
  -drive file=virtio-win.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
```
-> PRESS ENTER TWICE AFTER PASTING 
- Download VNC Viewer and Paste YOUR SERVER IP in VNC Viewer to Access the Installation Section
- Run the Installation Complete it and Install The Desire Drivers & Window
- Go to Server Manager > Turn on Remote Desktop, Goto Local Security > Security Option and disable The CTRL+ALT+DELETE Logon Option
- Restart Windows For Changes to take Effect Then Your'e Done!!

## Watch Video if you don't understand above text Instrctions ##
- Youtube:  link will be posted soon
## Last Step ##
Now Go back to SSH and Compress the img image to gz image using gzip

**Compress IMG to .gz File For Transfering to Cloud Providers**
```bash
dd if=windows.img | gzip -c>windows.gz
```

## Credits & Licence
This project is under the [MIT Licence] https://raw.githubusercontent.com/UncutDevs/create-windows-gz-using-qemu/main/LICENSE
