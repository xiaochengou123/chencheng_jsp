public class MultiplicationTable {
    public static void main(String[] args) {
        System.out.println("九九乘法表：");
        //二个for循环，从 i 1~9  ,j 1~9 
        for (int i = 1; i <= 9; i++) {
            for (int j = 1; j <= i; j++) {
                System.out.print(j + "×" + i + "=" + (i * j) + "\t");
            }
            System.out.println(); // 换行
        }
    }
}
