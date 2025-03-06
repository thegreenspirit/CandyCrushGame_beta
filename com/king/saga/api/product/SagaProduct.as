package com.king.saga.api.product
{
   import com.midasplayer.util.TypedKeyVal;
   
   public class SagaProduct
   {
      private var _id:int;
      
      private var _name:String;
      
      private var _cost:Money;
      
      private var _costLocal:Money;
      
      public function SagaProduct(param1:TypedKeyVal)
      {
         super();
         this._id = param1.getAsInt("id");
         this._name = param1.getAsString("name");
         this._cost = new Money(param1.getAsObject("cost"));
         if(param1.has("costLocal"))
         {
            this._costLocal = new Money(param1.getAsObject("costLocal"));
         }
      }
      
      public function getId() : int
      {
         return this._id;
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getCost() : Money
      {
         return this._cost;
      }
      
      public function getCostStr() : String
      {
         return this._cost.toString();
      }
      
      public function hasCostLocal() : Boolean
      {
         return this._costLocal != null;
      }
      
      public function getCostLocal() : Money
      {
         return this._costLocal;
      }
      
      public function getCostLocalStr() : String
      {
         return this._costLocal.toString();
      }
   }
}

