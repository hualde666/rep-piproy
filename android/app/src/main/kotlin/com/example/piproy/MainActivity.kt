package com.example.piproy


import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger

import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.plugins.GeneratedPluginRegistrant

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.telephony.SmsManager
import android.Manifest
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.ConnectivityManager.NetworkCallback
import 	android.net.NetworkCapabilities
import 	android.location.LocationManager
import android.hardware.camera2.CameraManager
import 	android.net.wifi.WifiNetworkSuggestion
import android.net.wifi.WifiManager
import android.net.Uri
class MainActivity: FlutterActivity() {
    
      private val CHANNEL = "app.piproy.channel/hualdemirene@gmail.com"

   
      override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
            super.configureFlutterEngine(flutterEngine)
               
              MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                  call, result ->
                  // Note: this method is invoked on the main thread.
                  // TODO
                  if (call.method == "mandarsms") {
                    val phone: String = (call.argument("phone") as? String) ?: ""
                    val mensaje: String = (call.argument("mensaje") as? String) ?:""
                    sendSms(phone,mensaje)
                                
                    //result.success(resultado)
                 
                  }
                  if (call.method == "version") {
                    val resultado = getAndroidVersion()
                    result.success(resultado)
                 
                  }
                  if (call.method == "aplicaciones") {
                    // val resultado = getListaApi()
                    // result.success(resultado)
                 
                  }
                  if (call.method == "wifi") {
                    val resultado = getWifi()
                    result.success(resultado)
    
                }
                if (call.method == "onoffwifi") {
                 // val prender: Boolean= (call.argument("prender") as? Boolean) ?: false
                  val resultado = true
                  result.success(resultado)
  
              }
              if (call.method == "onoffgps") {
                val prender: Boolean= (call.argument("prender") as? Boolean) ?: false
                onoffGps(prender)

            }
                if (call.method == "linterna") {
                  val prender: Boolean= (call.argument("prender") as? Boolean) ?: false
                  val resultado = prendeLinterna(prender)
                  result.success(resultado)
                }
                if (call.method == "gps") {
                  val resultado = getGps()
                  result.success(resultado)
  
              }
              if (call.method == "datos") {
                val resultado = getDatos()
                result.success(resultado)

            }
                  if (call.method == "cargando") {
                    val resultado = getCargaBateria()
                    result.success(resultado)
    
                }
                  if (call.method == "bateria") {
                    
                    val batteryLevel = getNivelBateria()
            
                    if (batteryLevel != -1) {
                     
                      result.success(batteryLevel)
                    } else {
                      result.error("UNAVAILABLE", "Battery level not available.", null)
                      println("error en bateria")
                    }
                  }
                 
                  else{
        
                  
                    result.notImplemented()
                  }
        
                }
              }
              // private fun getListaApi(){
              //   List<PackageInfo> packs = context.getPackageManager().getInstalledPackages(0);
              //   return packs
              // }
        
           private fun getAndroidVersion(): String {
                 val  sdkVersion: Int
                 val release: String
                 val respuesta: String
                 sdkVersion = VERSION.SDK_INT
                 release =VERSION.RELEASE
                 respuesta = "Android version: "+sdkVersion+ "release: "+release
                  return respuesta
                
              }

              private fun getNivelBateria(): Int{
        
                val batteryLevel: Int
                if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
                  val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                  batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                } else {
                  val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                  batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
               
                }
                return batteryLevel
              }
              private fun getCargaBateria(): Boolean{
           
                val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
                  context.registerReceiver(null, ifilter)
              }
              val status: Int = batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
              val isCharging: Boolean = status == BatteryManager.BATTERY_STATUS_CHARGING
                      || status == BatteryManager.BATTERY_STATUS_FULL
          
          
        
                return isCharging
            }
      
            private fun getWifi(): Boolean{
            

              val connectivityManager = this.getSystemService(android.content.Context.CONNECTIVITY_SERVICE)
                  as ConnectivityManager

              if (VERSION.SDK_INT >=VERSION_CODES.M) {
                      val networkCapabilities = connectivityManager.activeNetwork ?: return false
                      val activeNetwork = connectivityManager.getNetworkCapabilities(networkCapabilities) ?: return false

                  return when {

                  // activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) ||
                  //  activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) ||
            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
            
                    else -> false
                   }
                 }
             else {
                return false
              }
          }    
          private fun onoffWifi(): Boolean{
         
     

          //  manager.startLocalOnlyHotspot() 
        
            //     @Override
            //     public void onStopped() {
            //         super.onStopped();
            //         Log.d(TAG, "onStopped: ");
            //     }
        
            //     @Override
            //     public void onFailed(int reason) {
            //         super.onFailed(reason);
            //         Log.d(TAG, "onFailed: ");
            //     }
            // }, new Handler());
         
            return true
          }    
          private fun getGps(): Boolean{
            var locationManager =
            context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
              
              return true
            }
              return false
            
        } 
        private fun onoffGps(onoff: Boolean) {
  

          if(onoff){ //prender
          val poke = Intent()
          poke.setClassName("com.android.settings", "com.android.settings.widget.SettingsAppWidgetProvider"); 
          poke.addCategory(Intent.CATEGORY_ALTERNATIVE);
        
          poke.setData(Uri.parse("3")); 
          sendBroadcast(poke);
      
        }else{
          val  poke =  Intent();
          poke.setClassName("com.android.settings", "com.android.settings.widget.SettingsAppWidgetProvider");
          poke.addCategory(Intent.CATEGORY_ALTERNATIVE);
          poke.setData(Uri.parse("3")); 
          sendBroadcast(poke);
        }
        
      } 
        private fun getDatos(): Boolean{
              
 
          return true
        
    } 
    private fun prendeLinterna(prender: Boolean): Boolean{
   var camManager:CameraManager =   getSystemService(Context.CAMERA_SERVICE) as CameraManager;
  var  cameraId:String = camManager.getCameraIdList()[0]; // usualmente la camara delantera esta en la posicion 0
      camManager.setTorchMode(cameraId, prender);
 
      return true
    
} 
              private fun sendSms( phone: String, text: String) {
                
        
                val permissionCheck = ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS)
                if (permissionCheck == PackageManager.PERMISSION_GRANTED) {
                 
              myMessage(phone,text)
                  
                 

               } else {
                  ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.SEND_SMS),
                  101)
                  
               }
        
         
              }
              private fun myMessage(myNumber: String,myMsg: String) {
                
             
                      val smsManager: SmsManager = SmsManager.getDefault()
                      smsManager.sendTextMessage(myNumber, null, myMsg, null, null)
                      
                }
        
    
}
