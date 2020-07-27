#!/bin/sh

cd packages || exit

for plugin in */; do
    cd "$plugin" || exit
    case $1 in
        unit-test)
            echo "Running Flutter unit tests for $(basename "$plugin")"
            flutter test
            ;;
        android-test)
            echo "Running Android unit tests for $(basename "$plugin")"
            cd example/android || continue
            flutter build apk
            ./gradlew testDebugUnitTest
            cd ../..
            ;;
        ios-test)
            echo "Running iOS unit tests for $(basename "$plugin")"
            cd example/ios || continue
            flutter build ios --no-codesign
            xcodebuild test -workspace Runner.xcworkspace -scheme Runner -destination 'platform=iOS Simulator,name=iPhone 11,OS=13.6'
            cd ../..
            ;;
    esac
    cd ..
done

cd ..
