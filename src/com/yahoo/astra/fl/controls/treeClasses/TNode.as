package com.yahoo.astra.fl.controls.treeClasses
{
   public dynamic class TNode
   {
      protected var _nodeLevel:int;
      
      protected var _parentDataProvider:TreeDataProvider;
      
      protected var _parentNode:BranchNode;
      
      public function TNode(param1:TreeDataProvider)
      {
         super();
         _parentDataProvider = param1;
      }
      
      public function get nodeLevel() : int
      {
         return _nodeLevel;
      }
      
      public function drawNode() : void
      {
      }
      
      public function isVisible() : Boolean
      {
         var _loc1_:BranchNode = null;
         _loc1_ = _parentNode as BranchNode;
         while(!(_loc1_ is RootNode))
         {
            if(!_loc1_.isOpen())
            {
               return false;
            }
            _loc1_ = _loc1_.parentNode;
         }
         return true;
      }
      
      public function get parentNode() : BranchNode
      {
         return _parentNode;
      }
      
      public function set nodeLevel(param1:int) : void
      {
         if(param1 == _parentNode.nodeLevel + 1)
         {
            _nodeLevel = param1;
         }
      }
      
      public function removeNode() : TNode
      {
         this.parentNode.removeChild(this);
         return this;
      }
      
      public function set parentNode(param1:BranchNode) : void
      {
         if(param1.children.indexOf(this) >= 0)
         {
            _parentNode = param1;
         }
      }
      
      public function hideNode() : void
      {
      }
   }
}

