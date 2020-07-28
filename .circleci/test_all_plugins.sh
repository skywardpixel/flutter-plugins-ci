#!/bin/sh

cd packages || exit

for plugin_dir in */; do
    cd "$plugin_dir" || exit
    plugin=$(basename "$plugin_dir")
    case $1 in
        unit-test)
            echo "=== Running Flutter unit tests for $plugin ==="
            flutter test
            ;;
        android-test)
            echo "=== Running Android unit tests for $plugin ==="
            cd example/android || continue
            flutter build apk
            ./gradlew testDebugUnitTest
            cd ../..
            ;;
        ios-test)
            echo "=== Running iOS unit tests for $plugin ==="
            if [ -d "ios/Tests" ]; then
                XCODEBUILD_DESTINATION="'platform=iOS Simulator,name=iPhone 11,OS=13.6'"
                cd example/ios || continue
                flutter build ios --no-codesign
                xcodebuild test -workspace Runner.xcworkspace -scheme Runner -destination "$XCODEBUILD_DESTINATION"
                cd ../..
            else
                echo "iOS unit tests for $plugin don't exist. Skipping."
            fi
            ;;
    esac
    cd ..
    echo
done

cd ..
