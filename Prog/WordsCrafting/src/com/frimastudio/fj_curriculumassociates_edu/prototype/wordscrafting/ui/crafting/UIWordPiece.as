package com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.crafting 
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.wordscrafting.word.WordPiece;
	import flash.geom.Point;
	
	public class UIWordPiece extends UIButton
	{
		private var mWordPiece:WordPiece;
		
		public function get Piece():WordPiece
		{
			return mWordPiece;
		}
		
		public function UIWordPiece(aWordPiece:WordPiece)
		{
			super(new Point(50, 50), aWordPiece.PieceString);
			
			mWordPiece = aWordPiece;
		}
	}
}