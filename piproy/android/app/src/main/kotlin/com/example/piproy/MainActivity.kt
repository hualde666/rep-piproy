
package com.example.piproy

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}

// package com.example.flutter_pruebas

// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.plugin.common.MethodChannel
// import io.flutter.plugin.common.BinaryMessenger
// import androidx.annotation.NonNull;
// import androidx.core.app.ActivityCompat
// import androidx.core.content.ContextCompat
// import io.flutter.embedding.engine.FlutterEngine;

// import android.content.Context
// import android.content.ContextWrapper
// import android.content.Intent
// import android.content.IntentFilter
// import android.os.BatteryManager
// import android.os.Build.VERSION
// import android.os.Build.VERSION_CODES
// import android.os.Bundle
// import android.telephony.SmsManager
// import android.Manifest
// import android.content.pm.PackageManager
// class MainActivity: FlutterActivity() {

  //    private val CHANNEL = "app.piproy.channel/hualdemirene@gmail.com"
   

   
  // override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
  //   super.configureFlutterEngine(flutterEngine)
       
  //       MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
  //         call, result ->
  //         // Note: this method is invoked on the main thread.
  //         // TODO
  //         if (call.method == "mandarsms") {
  //           val phone: String = (call.argument("phone") as? String) ?: ""
  //           val mensaje: String = (call.argument("mensaje") as? String) ?:""
  //           val resultado = sendSms(phone,mensaje)
         
  //           result.success(resultado)
         
  //         }
  //         if (call.method == "version") {
  //           val resultado = getAndroidVersion()
  //           result.success(resultado)
         
  //         }
  //         if (call.method == "bateria") {
            
  //           val batteryLevel = getNivelBateria()
    
  //           if (batteryLevel != -1) {
  //             result.success(batteryLevel)
  //           } else {
  //             result.error("UNAVAILABLE", "Battery level not available.", null)
  //           }
  //         }else{

          
  //           result.notImplemented()
  //         }

  //       }
  //     }

  //   private fun getAndroidVersion(): String {

  //        val  sdkVersion: Int
  //        val release: String
  //        val respuesta: String
  //        sdkVersion = VERSION.SDK_INT
  //        release =VERSION.RELEASE
  //        respuesta = "Android version: "+sdkVersion+ "release: "+release
  //         return respuesta
        
  //     }
  //     private fun getNivelBateria(): Int{

  //       val batteryLevel: Int
  //       if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
  //         val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
  //         batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
  //       } else {
  //         val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
  //         batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
  //       }
    
  //       return batteryLevel
  //     }


  //     private fun sendSms( phone: String, text: String) {
        

  //       val permissionCheck = ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS)
  //       if (permissionCheck == PackageManager.PERMISSION_GRANTED) {
         
  //         myMessage(phone,text)
  //      } else {
  //         ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.SEND_SMS),
  //         101)
  //      }

  //   }
      
  //     private fun myMessage(myNumber: String,myMsg: String) {
        
     
  //             val smsManager: SmsManager = SmsManager.getDefault()
  //             return smsManager.sendTextMessage(myNumber, null, myMsg, null, null)
              
  //       }
       
   

    
