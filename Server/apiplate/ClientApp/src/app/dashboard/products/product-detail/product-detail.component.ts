import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Product } from 'src/app/core/models/product.model';
import { Option } from 'src/app/core/models/option.model';

import { ProductsService } from 'src/app/core/services/products.service';
import { AddOn } from 'src/app/core/models/add-on.model';
import { AddonsService } from 'src/app/core/services/addons.service';
import { OptionsService } from 'src/app/core/services/options.service';
import { FuiModalService } from 'ngx-fomantic-ui';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';
import { Image } from 'src/app/core/models/image.model';
import { FileManagerModal } from '../../file-manager/file-manager-modal/file-manager-modal.component';
import { PickingMode } from '../../file-manager/file-manager.component';
import { FileModel } from 'src/app/core/models/file.Model';

@Component({
  selector: 'app-product-detail',
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.scss']
})
export class ProductDetailComponent implements OnInit {
  public product:Product;
  options:Option[] = [];
  addons:AddOn[] = [];
  dimLoading = false;
  isLoading = false;
  optionsCols = [ 

    {
      prop: "id",
      title: "الرقم التعريفي",
      show: true,
      sortable: true

    },

    {
      prop: "title",
      title: "اسم الخيار",
      show: true,
      sortable: true

    },
    {
      prop: "values",
      title: "عدد العناصر",
      show: true,
      sortable: true

    },
   {
      prop: "Actions",
      title: "الافعال",
      show: true,

    }
  ];
  addOnsCols = [
    {
      prop: "id",
      title: "الرقم التعريفي",
      show: true,
      sortable: true

    },

    {
      prop: "title",
      title: "اسم الاضافة",
      show: true,
      sortable: true

    },
    {
      prop: "price",
      title: "القيمة",
      show: true,
      sortable: true

    },


    {
      prop: "Actions",
      title: "الافعال",
      show: true,

    }
  ]

  constructor(private _service:ProductsService,private _optionService:OptionsService,private _addOnsService:AddonsService,private activatedRoute:ActivatedRoute,private modalService: FuiModalService,) {
      this.activatedRoute.params.subscribe(res => {
        this.getProduct(res['id']);
      });
   }
   addOption(option?:Option)
   {
    this.dimLoading = true;
    this._service.addOption(this.product.id,option.id).subscribe(res =>{
        this.product.options.push(option);
        this.dimLoading = true;
        this.modalService.open(new MessageModal({
          title: "نجاح",
          content: "تم اضافة الخيار بنجاح", isConfirm: false, messageType: MessageTypes.Success
        }))
      this.dimLoading = false;

    },err =>{
      this.dimLoading = false;
    })
   }
   removeOption(option?:Option)
   {
    this.dimLoading = true;
    this._service.removeOption(this.product.id,option.id).subscribe(res =>{
        var optionIndex = this.product.options.indexOf(option);
        this.product.options.splice(optionIndex,1);
        this.modalService.open(new MessageModal({
          title: "نجاح",
          content: "تم حذف الخيار بنجاح", isConfirm: false, messageType: MessageTypes.Success
        }))
      this.dimLoading = false;
        
    },err =>{
      this.dimLoading = false;
    })
   }
   addAddon(addon?:AddOn)
   {
    this.dimLoading = true;
    this._service.addAddon(this.product.id,addon.id).subscribe(res =>{
        this.product.addOns.push(addon);
        this.dimLoading = true;
        this.modalService.open(new MessageModal({
          title: "نجاح",
          content: "تم اضافة الاضافة بنجاح", isConfirm: false, messageType: MessageTypes.Success
        }))
      this.dimLoading = false;

    },err =>{
      this.dimLoading = false;
    })
   }
   removeAddon(addon?:AddOn)
   {
    this.dimLoading = true;
    this._service.removeAddon(this.product.id,addon.id).subscribe(res =>{
        var addonIndex = this.product.addOns.indexOf(addon);
        this.product.addOns.splice(addonIndex,1);
        this.modalService.open(new MessageModal({
          title: "نجاح",
          content: "تم حذف الاضافة بنجاح", isConfirm: false, messageType: MessageTypes.Success
        }))
      this.dimLoading = false;

        
    },err =>{
      this.dimLoading = false;
    })
   }
   addImage(path?:string)
   {
    this.dimLoading = true;
    this._service.addImage(this.product.id,path).subscribe(res =>{
        this.product.images.push({path:path});
        this.dimLoading = true;
        this.modalService.open(new MessageModal({
          title: "نجاح",
          content: "تم اضافة الصورة بنجاح", isConfirm: false, messageType: MessageTypes.Success
        }))
      this.dimLoading = false;

    },err =>{
      this.dimLoading = false;
    })
   }
   removeImage(image:Image)
   {
    this.dimLoading = true;
    this._service.removeImage(this.product.id,image.id).subscribe(res =>{
        
        var imageIndex = this.product.images.indexOf(image);
        this.product.images.splice(imageIndex,1);
        this.modalService.open(new MessageModal({
          title: "نجاح",
          content: "تم حذف الصورة بنجاح", isConfirm: false, messageType: MessageTypes.Success
        }))
      this.dimLoading = false;

        
    },err =>{
      this.dimLoading = false;
    })
   }
   getOptions(){
      this._optionService.get().subscribe(res =>{
        this.options = res.data; 
      },err => this.isLoading = false)
   }
   getAddons(){
    this._addOnsService.get().subscribe(res =>{
      this.addons = res.data; 
      this.isLoading = false;

    },err => this.isLoading = false);
 }
   getProduct(id:number)
   {

       this.isLoading = true;
      this._service.single(id).subscribe(res => {
          this.product = res.data;
          this.getOptions();
          this.getAddons();
      },err => {
        console.log(err)
        this.isLoading = false;
      });
   }
   openFMModal(){
    this.modalService.open(new FileManagerModal({ title: "Pick Image", pickingMode: PickingMode.Files })).onApprove((result: FileModel[]) => {
       if(result.length > 0)
       {
         this.addImage(result[0].uri);
       }
    });
   }
  ngOnInit(): void {
  }

}
