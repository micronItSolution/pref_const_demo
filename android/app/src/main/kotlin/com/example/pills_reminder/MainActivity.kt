package com.example.pills_reminder

import android.app.Activity
import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugins.GeneratedPluginRegistrant
import java.lang.ref.WeakReference
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "ringtone_channel"
    var methodChannel: MethodChannel? = null
    private lateinit var result: Result
    var ringtone : Ringtone? =null
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        provideFlutterEngine(this)?.let {
            GeneratedPluginRegistrant.registerWith(it)
            Log.e("TAG", "onCreate:::Main==>> ")
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel!!.setMethodCallHandler { call, result ->
            this.result = result
            if (call.method.equals("getSystemRingtones")) {
                getSystemRingtones()
            }else if (call.method.equals("playSystemRingtone")){
                ringtone = RingtoneManager.getRingtone(
                    this,
                    Uri.parse(call.arguments.toString())
                )
                ringtone!!.play()
                if(ringtone!!.isPlaying){
                    Log.d(
                        "RingtonePicker",
                        "ringtone.isPlaying: ${ringtone!!.isPlaying}"
                    )
                    this.result.success(true)
                }

//                if(ringtone.isPlaying) result.success(ringtone.isPlaying)
            }else if (call.method.equals("stopSystemRingtone")){
                if(ringtone!=null && ringtone!!.isPlaying){
                    ringtone!!.stop()
                    result.success(false)
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "dexterx.dev/flutter_local_notifications_example").setMethodCallHandler { call, result ->
            if ("drawableToUri" == call.method) {
                val resourceId = this@MainActivity.resources.getIdentifier(call.arguments as String, "drawable", this@MainActivity.packageName)
                result.success(resourceToUriString(this@MainActivity.applicationContext, resourceId))
            }
            if ("getAlarmUri" == call.method) {
                result.success(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM).toString())
            }
        }
    }
    private fun resourceToUriString(context: Context, resId: Int): String? {
        return (ContentResolver.SCHEME_ANDROID_RESOURCE + "://"
                + context.resources.getResourcePackageName(resId)
                + "/"
                + context.resources.getResourceTypeName(resId)
                + "/"
                + context.resources.getResourceEntryName(resId))
    }
    private fun getSystemRingtones() {
        val ringtone = Intent(RingtoneManager.ACTION_RINGTONE_PICKER)
        ringtone.putExtra(RingtoneManager.EXTRA_RINGTONE_TYPE, RingtoneManager.TYPE_RINGTONE);
        ringtone.putExtra(RingtoneManager.EXTRA_RINGTONE_SHOW_DEFAULT, true);
        ringtone.putExtra(
            RingtoneManager.EXTRA_RINGTONE_DEFAULT_URI,
            RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
        )
        startActivityForResult(ringtone, 5)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == RESULT_OK && requestCode==5) {
            if (data != null) {

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    Log.d(
                        "RingtonePicker", "Selected Ringtone: ${
                            data.getParcelableExtra(
                                RingtoneManager.EXTRA_RINGTONE_PICKED_URI,
                                Uri::class.java
                            )!!
                        }"
                    )
                    val ringtone = RingtoneManager.getRingtone(
                        this,
                        data.getParcelableExtra(
                            RingtoneManager.EXTRA_RINGTONE_PICKED_URI,
                            Uri::class.java
                        )!!
                    )
//                    val ringUri = RingtoneManager.getValidRingtoneUri(this)
//                    Log.d(
//                        "RingtonePicker",
//                        "Selected Ringtone: $ringUri"
//                    )
                    val ringtoneInfo = mapOf(
                        "URI" to data.getParcelableExtra(
                            RingtoneManager.EXTRA_RINGTONE_PICKED_URI,
                            Uri::class.java
                        ).toString(),
                        "Title" to ringtone.getTitle(this).toString()
                    )
                    result.apply { success(ringtoneInfo) }
                } else {
                    Log.d(
                        "RingtonePicker",
                        "Selected Ringtone: ${data.getParcelableExtra<Uri>(RingtoneManager.EXTRA_RINGTONE_PICKED_URI)!!}"
                    )
                    val ringtone = RingtoneManager.getRingtone(
                        this,
                        data.getParcelableExtra<Uri>(RingtoneManager.EXTRA_RINGTONE_PICKED_URI)!!
                    )
                    val ringtoneInfo = mapOf(
                        "URI" to data.getParcelableExtra<Uri>(
                            RingtoneManager.EXTRA_RINGTONE_PICKED_URI
                        )!!.toString(),
                        "Title" to ringtone.getTitle(this).toString()
                    )

                    result.apply { success(ringtoneInfo) }
                }
            } else {
                Log.d("RingtonePicker", "No ringtone selected")
            }
        }
    }
}
