package com.yahoo.astra.fl.controls.treeClasses
{
   public dynamic class LeafNode extends TNode
   {
      protected var _nodeType:String;
      
      public function LeafNode(param1:TreeDataProvider)
      {
         super(param1);
         _nodeType = TreeDataProvider.LEAF_NODE;
      }
      
      override public function drawNode() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_parentDataProvider.getItemIndex(this) == -1 && isVisible())
         {
            _loc1_ = int(_parentNode.children.indexOf(this));
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ += _parentNode.children[_loc3_].getVisibleSize();
               _loc3_++;
            }
            if(_parentNode is RootNode)
            {
               if(_parentDataProvider.length > 0)
               {
                  _parentDataProvider.addItemAt(this,_loc2_);
               }
               else
               {
                  _parentDataProvider.addItem(this);
               }
            }
            else
            {
               _loc4_ = _parentDataProvider.getItemIndex(_parentNode);
               _parentDataProvider.addItemAt(this,_loc4_ + _loc2_ + 1);
            }
         }
      }
      
      public function checkForValue(param1:String, param2:String) : TNode
      {
         if(this[param1] == param2)
         {
            return this as TNode;
         }
         return null;
      }
      
      public function get nodeType() : String
      {
         return _nodeType;
      }
      
      override public function hideNode() : void
      {
         if(_parentDataProvider.getItemIndex(this) != -1 && !isVisible())
         {
            _parentDataProvider.removeItem(this);
         }
      }
      
      public function getVisibleSize() : int
      {
         return 1;
      }
   }
}

