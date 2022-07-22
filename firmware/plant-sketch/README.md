The firmware is based on the [4G LTE Connected Smart Wildlife Camera](https://github.com/edgeimpulse/ei-spresense-4g-wildlife-camera) provided by Edge Impulse.

- Create an [Edge Impulse](https://github.com/edgeimpulse/ei-spresense-4g-wildlife-camera/blob/main/www.edgeimpulse.com) account
- Install the [Arduino IDE](https://www.arduino.cc/en/software)
- Install the [Spresense Arduino Library](https://developer.sony.com/develop/spresense/docs/arduino_set_up_en.html#_install_spresense_arduino_library)
- In `Tools->Board` select the `Spresense` device, then under `Tools->Memory` select `1536(kB)`.
- Clone this repo
- From Edge Impulse, clone the TODO!!!! repository
- In your cloned Edge Impulse project, select `Arduino Library` and click `build`. Follow the instructions to add this library to your Arduino IDE
- In the Arduino IDE, click `File->Ope`n and then navigate to `greenhouse-ai` repository folder, and open the `plan-sketch.ino` file
- Build the project to verify it compiles correctly
- In the `4g_camera.ino` file, configure the APN with your SIM card details.
- Also in `4g_camera.ino`, specify the web server details.
- Now, rebuild and upload the sketch.            