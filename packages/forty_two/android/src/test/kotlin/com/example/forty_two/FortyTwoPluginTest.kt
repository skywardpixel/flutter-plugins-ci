import org.junit.Test
import org.junit.Assert.*;

class FortyTwoPluginTest {
    @Test
    fun onTestRun() {
        print("Hello, this is a test")
    }

    @Test
    fun onTestRun_fail() {
        print("Hello, this is a failing test")
        assertTrue(false)
    }
}