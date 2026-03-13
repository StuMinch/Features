# Backtrace SDK Validation & Testing Guide

## Summary of Changes

### 1. Fixed AppDelegate.swift Issues ✅

**Problems Found:**
- ❌ `BacktraceClientConfiguration` was created but discarded (assigned to `_`)
- ❌ `PLCrashReporterConfig` was created but never passed to the client
- ❌ `BacktraceCrashReporter` was created but never used
- ❌ No error handling for SDK initialization
- ❌ Missing breadcrumbs initialization
- ❌ No global attributes set

**Fixed:**
- ✅ Configuration is now properly used when initializing the client
- ✅ Custom PLCrashReporter config is passed to BacktraceClient
- ✅ Proper error handling with do-catch block
- ✅ Breadcrumbs enabled automatically
- ✅ Global attributes added (app environment, version)
- ✅ Better logging with emoji indicators for status

### 2. Created BacktraceTestView.swift ✅

A comprehensive testing interface that allows you to:
- Check SDK initialization status
- Send test error reports
- Test custom attributes
- Test breadcrumbs functionality
- Test exception handling
- Simulate crashes (for testing crash reporting on next app launch)
- View test results in real-time

### 3. Added Navigation Link in ContentView.swift ✅

Added "Backtrace SDK Test" option to the main features list for easy access.

---

## How to Test the Backtrace SDK

### Step 1: Check Configuration

Ensure your `Info.plist` has the `BacktraceURL` key set:
```xml
<key>BacktraceURL</key>
<string>https://submit.backtrace.io/YOUR_UNIVERSE/YOUR_TOKEN/plcrash</string>
```

Or verify your `Secrets.xcconfig` is properly configured with:
```
BACKTRACE_SUBMISSION_URL = https://submit.backtrace.io/...
```

### Step 2: Build Settings for dSYM Files

For proper crash symbolication, ensure these build settings are correct:

**For Release Configuration:**
- **Debug Information Format**: `DWARF with dSYM File`
- **Generate Debug Symbols**: `YES`
- **Strip Debug Symbols During Copy**: `NO`
- **Deployment Postprocessing**: `YES`
- **Strip Style**: `non-global`

**For Debug Configuration:**
- **Debug Information Format**: `DWARF`
- **Generate Debug Symbols**: `YES`

### Step 3: Run the App

1. Build and run the app
2. Check the console for: `✅ Backtrace SDK initialized successfully`
3. If you see `⚠️` or `❌`, check your configuration

### Step 4: Use the Test View

Navigate to "Backtrace SDK Test" from the main menu and run tests:

#### Test 1: Basic Report
- Sends a simple error message
- Verifies basic SDK functionality
- Check your Backtrace dashboard for the report

#### Test 2: Report with Attributes
- Sends a report with custom attributes
- Attributes include:
  - `test.type`
  - `test.timestamp`
  - `test.user`
  - `test.screen`
- Verify these appear in the Backtrace dashboard

#### Test 3: Breadcrumbs
- Adds multiple breadcrumbs
- Sends a report that includes breadcrumb trail
- Check dashboard to see the breadcrumb history

#### Test 4: Exception Handling
- Sends an NSException report
- Includes custom userInfo
- Verify exception details in dashboard

#### Test 5: Crash Simulation ⚠️
- **WARNING**: This will crash the app!
- The crash report will be sent on next app launch
- Restart the app and check dashboard for crash report

---

## Verifying dSYM Files

### Where to Find dSYM Files

After a Release build, dSYM files are located at:
```
~/Library/Developer/Xcode/DerivedData/Features-[hash]/Build/Products/Release-iphoneos/Features.app.dSYM
```

### Verify dSYM is Valid

Use this command to check if your dSYM file contains symbols:
```bash
dwarfdump --uuid ~/Path/To/Features.app.dSYM
```

You should see output like:
```
UUID: 12345678-90AB-CDEF-1234-567890ABCDEF (arm64) Features.app.dSYM/Contents/Resources/DWARF/Features
```

If the file is empty or shows no UUID, check your build settings.

### Upload dSYM to Backtrace

You can manually upload dSYM files or automate it:

#### Manual Upload
1. Go to your Backtrace project
2. Navigate to Project Settings → Symbols
3. Upload the `.dSYM` file or zipped dSYM folder

#### Automated Upload (Recommended)
Add a Run Script Phase in Xcode:

1. Select your target
2. Build Phases → + → New Run Script Phase
3. Add this script:

```bash
#!/bin/bash

if [ "$CONFIGURATION" == "Release" ]; then
    DSYM_PATH="${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
    
    if [ -d "$DSYM_PATH" ]; then
        echo "Uploading dSYM to Backtrace..."
        
        # Zip the dSYM
        DSYM_ZIP="${DSYM_PATH}.zip"
        zip -r "$DSYM_ZIP" "$DSYM_PATH"
        
        # Upload to Backtrace
        curl -X POST \
            -F "upload_file=@${DSYM_ZIP}" \
            "${BACKTRACE_SUBMISSION_URL}/symbols"
        
        echo "dSYM upload complete"
    else
        echo "Warning: dSYM file not found at $DSYM_PATH"
    fi
fi
```

---

## Troubleshooting

### SDK Not Initialized
- Check console for error messages
- Verify `BacktraceURL` in Info.plist
- Ensure URL format is correct

### Reports Not Appearing in Dashboard
- Check network connectivity
- Verify submission URL is correct
- Check rate limiting (default: 10 reports per minute)
- Look for error messages in completion handlers

### Empty dSYM Files
- Verify Debug Information Format is set to `DWARF with dSYM File` for Release
- Clean build folder and rebuild
- Check that `COPY_PHASE_STRIP = NO`

### Crash Reports Not Symbolicated
- Ensure dSYM files are uploaded to Backtrace
- Verify dSYM UUID matches the crash report UUID
- Check that symbols are properly indexed in Backtrace

### Breadcrumbs Not Showing
- Ensure `enableBreadcrumbs()` is called (now automatic in AppDelegate)
- Check that breadcrumbs are added before the report
- Verify breadcrumb settings in Backtrace dashboard

---

## Best Practices

1. **Always enable breadcrumbs** - Provides context for crashes
2. **Add meaningful attributes** - User ID, session ID, feature flags, etc.
3. **Use proper error levels** - Info, Debug, Warning, Error
4. **Test on real devices** - Simulator behavior may differ
5. **Upload dSYMs immediately** - Automate with build scripts
6. **Monitor OOM crashes** - Already enabled with `oomMode: .full`
7. **Set up alerts** - Configure Backtrace to notify on critical errors

---

## Additional Features to Consider

### Network Monitoring
Add network request attributes to reports:
```swift
BacktraceClient.shared?.attributes["network.status"] = "online"
BacktraceClient.shared?.attributes["network.type"] = "wifi"
```

### User Session Tracking
Track user sessions:
```swift
BacktraceClient.shared?.attributes["session.id"] = UUID().uuidString
BacktraceClient.shared?.attributes["user.id"] = "user123"
```

### Feature Flags
Include feature flag state:
```swift
BacktraceClient.shared?.attributes["feature.applePay.enabled"] = "true"
```

### Performance Metrics
Add performance data:
```swift
BacktraceClient.shared?.attributes["performance.memoryUsage"] = "\(memoryUsage)MB"
```

---

## Next Steps

1. ✅ Review fixed `AppDelegate.swift`
2. ✅ Run the app and check console for initialization message
3. ✅ Navigate to "Backtrace SDK Test" in the app
4. ✅ Run each test and verify results
5. ✅ Check Backtrace dashboard for received reports
6. ✅ Verify build settings for dSYM generation
7. ✅ Test crash reporting (optional, will restart app)
8. ✅ Upload dSYM files to Backtrace
9. ✅ Set up automated dSYM upload script
10. ✅ Configure alerts in Backtrace dashboard

---

## Contact & Resources

- Backtrace Documentation: https://docs.backtrace.io/
- SDK Source Code: The SDK is included in your project
- Submission URL: Check `Secrets.xcconfig`
