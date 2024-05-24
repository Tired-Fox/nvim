class Test {
	private static void helloWorld(final String... args) {
		System.out.println("Hello, world!");
	}

	public static void main(String[] args) {
		Test.helloWorld("Something", "here", "right", "now");
	}
}
