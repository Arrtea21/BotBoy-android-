//import 'somedatabaseig'

String reply({String userText})
{
	int i=0, x=0;
	String str;
	List<String> tokens = new List<String>();
	for(i=0;i<userText.length;i++)
	{
		if(userText[i]==' ')
		{
			tokens.add(userText.substring(x,i));
			x=i+1;
		}
		if(i==userText.length-1)
		{
			tokens.add(userText.substring(x,i+1));
			x=i+1;
		}
	}
	for(i=0;i<tokens.length;i++)
		{
			if(i==0)
				str =tokens[i];
			else
				str +=' '+tokens[i];
		}
	print(tokens);
	return str;
  /*if(userText=='Hello')
		return 'Hello! How are you';
	if(userText=='good')
		return 'Noice';
	if(userText==':)')
		return ':/';
	else
	  return 'ok';*/
}