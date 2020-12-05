package my_pack;


public class ColorInfo
{
	static String[] color_list = {"#a2d5f2","#ade498","#f9d56e","#ffc7c7"};
	
	public static String getColor(int code)
	{
		return color_list[code];
	}
}
