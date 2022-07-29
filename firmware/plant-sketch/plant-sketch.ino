
#include <SDHCI.h>
#include <RTC.h>
#include <LowPower.h>
#include <GNSS.h>

#define DEBUG true
static SDClass  theSD;
static int batteryVoltage;
static SpNavData data;

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

  // device attempts to connect to cellular
  ei_camera_connect_cellular(DEBUG);

  //camera starts continuously classifying video feed at 5fps
  ei_camera_start_continuous(DEBUG);
}

void loop() {
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

  sleep(60);
  
  // retry cellular connection
  Serial.println("Reconnect cellular..");
  ei_camera_connect_cellular(DEBUG);
  // restart continuously classifying video feed at 5fps
  Serial.println("Start streaming again..");
  ei_camera_start_continuous(DEBUG);
}
