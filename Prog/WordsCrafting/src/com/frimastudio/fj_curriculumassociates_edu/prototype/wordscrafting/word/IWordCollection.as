package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word
{
	import flash.utils.Dictionary;
	
	public interface IWordCollection
	{
		function get Collection():Dictionary;
		
		function ContainWord(aWord:Word):Boolean;
		
		function AddWord(aWord:Word):void;
	}
}