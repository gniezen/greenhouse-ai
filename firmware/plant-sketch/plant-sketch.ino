
#include <SDHCI.h>
#include <RTC.h>
#include <LowPower.h>

#define DEBUG true
static SDClass  theSD;
static int batteryVoltage;

void setup() {
  if (DEBUG) {
    Serial.begin(115200); 
    Serial.println("INFO: camera initializing on wakeup...");
  }

  LowPower.begin();

  /* Initialize SD */
  while (!theSD.begin()) 
  {
    /* wait until SD card is mounted. */
    if (DEBUG) Serial.println("Insert SD card.");
  }

  if (DEBUG) Serial.println("SD card mounted.");

  // Initialize RTC at first
  RTC.begin();

  // Set the temporary RTC time
  RtcTime compiledDateTime(__DATE__, __TIME__);
  RTC.setTime(compiledDateTime);

  setupGnss();
  if (DEBUG) Serial.println("INFO: gnss started");

  sleep(5000); // TODO: change to deep sleep
  // device attempts to connect to cellular
  ei_camera_connect_cellular(DEBUG);

  //camera starts continuously classifying video feed at 5fps
  ei_camera_start_continuous(DEBUG);
}

void loop() {

  // Serial.println("Going to deep sleep..");
  // LowPower.deepSleep(3);
  // this routine is used to validate when we have valid GNSS data
  // camera video feed events have generally been paused if this is running
  if (!loopGnss()) {

    if (DEBUG) {
      Serial.println("gnss update failed, data:");
      Serial.println(sprintNavData());
    }
  } else if (DEBUG) {
    Serial.println("gnss update:");
    Serial.println(sprintNavData());
  }
  
  // retry cellular connection
  // ei_camera_connect_cellular(DEBUG);
  // restart continuously classifying video feed at 5fps
  // sleep(5000);
  // Serial.println("Attempting to restart camera");
  // ei_camera_start_continuous(DEBUG);
}
