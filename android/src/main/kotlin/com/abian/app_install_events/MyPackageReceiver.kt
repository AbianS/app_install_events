import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.EventChannel.EventSink

class MyPackageReceiver(private val eventSink: EventSink?) : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent != null) {
            val packageName = intent.data?.schemeSpecificPart
            if (packageName != null) {
                if (intent.action == Intent.ACTION_PACKAGE_ADDED) {
                    // Send the install event to Flutter
                    eventSink?.success("AppInstalled:$packageName")
                } else if (intent.action == Intent.ACTION_PACKAGE_REMOVED) {
                    // Send the uninstall event to Flutter
                    eventSink?.success("AppUninstalled:$packageName")
                }
            }
        }
    }
}
