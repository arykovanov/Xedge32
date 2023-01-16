<pre>
<?lsp

--To run this code:

-- Wire up a BME280 via I2C:
-- https://learn.sparkfun.com/tutorials/sparkfun-bme280-breakout-hookup-guide/all
--  1: Upload bme280.lua to the .lua directory i.e. to http://esp32-ip/fs/.lua/
--  2: Create an app using the LSP App Manager and add this file to the app
--  3: Set the GPIO settings below
--  4: Run this file as an LSP page


local SDA_GPIO <const> = 21
local SCL_GPIO <const> = 22
local BME280_I2C_ADDR <const> = 0x76

local settings={
   tStandby=1,
   filter=4,
   pressOverSample=5,
   humidOverSample=1,
   tempOverSample=2
}

local bme,err = require"bme280".create(0, BME280_I2C_ADDR, SDA_GPIO, SCL_GPIO, settings)
if bme then
   local temperature, humidity, pressure = bme:read()
   print(string.format("Temperature:  %0.2f, Humidity:  %0.2f, Pressure:  %0.2f",
                       temperature,humidity,pressure/100))
   bme:close()
end


?>
</pre>

