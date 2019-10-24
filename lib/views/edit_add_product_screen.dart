import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
class EditAddProductScreen extends StatefulWidget {
  static const routeName = '/edit-Add-Product';
  @override
  _EditAddProductScreenState createState() => _EditAddProductScreenState();
}

class _EditAddProductScreenState extends State<EditAddProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _productUrl = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null,
      title: null,
      description: null,
      price: 0,
      imageUrl: null,
      isFavorite: false
  );

  var _isInit = true;
  var _isLoading = false;

  var _initValues = {
    'title': '',
    'description':'',
    'price':'',
    'imageUrl':'',
  };

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _productUrl.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }
  //runs before everything
  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }
  //runs before builder is executed
  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        final _editedProduct = Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          //'imageUrl':_editedProduct.imageUrl,
          'imageUrl': ''
        };

        _productUrl.text = _editedProduct.imageUrl;
      }
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){

      if(_productUrl.text.isEmpty){
        return;
      }

      if(!_productUrl.text.startsWith('http') || !_productUrl.text.startsWith('https')){
        return;

      }

      if(!_productUrl.text.endsWith('.png') && !_productUrl.text.endsWith('.jpg') && !_productUrl.text.endsWith('.jpeg')){
        return;
      }

      setState(() {

      });
    }
  }

  void _saveForm(){
    final isValid = _form.currentState.validate();



    if(!isValid){
      return;
    }

    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();
    if(_editedProduct.id != null){
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }else{
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct).catchError((error) {
        return showDialog(context: context, builder: (cont) => AlertDialog(title: Text('An error occurred!'), content: Text('Something went wrong.') , actions: <Widget>[
          FlatButton(child: Text('Okay'), onPressed: (){
            Navigator.of(context).pop();
          } ,)
        ],));
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                    labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if(value.isEmpty){
                    return 'Input cannot be empty';
                  }
                  return null;

                },
                onSaved: (value){
                  _editedProduct = Product(
                    title: value,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if(value.isEmpty){
                    return 'Please enter a price';
                  }
                  if(double.tryParse(value) == null){
                    return 'Please enter a valid number';
                  }
                  if(double.parse(value) <= 0){
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);

                },
                  onSaved: (value){
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: double.parse(value),
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite

                    );
                  }

              ),
              TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(
                      labelText: 'Description'
                  ),
//                textInputAction: TextInputAction.next,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Please enter a description.';
                    }

                    if(value.length < 10){
                      return 'Desciption should be less than 10';
                    }

                    return null;
                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value){
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: value,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite

                    );
                  }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey

                    )),
                    child: _productUrl.text.isEmpty ? Text('Enter a URL') : FittedBox(
                      child: Image.network(
                        _productUrl.text,
                        fit: BoxFit.cover,),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      //initialValue: _initValues['imageUrl'],
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _productUrl,
                      validator: (value) {

                        if(value.isEmpty){
                          return 'Please enter an image url';
                        }

                        if(!value.startsWith('http') || !value.startsWith('https')){
                          return 'Please enter a valid URL';

                        }
                        
                        if(!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')){
                          return 'This is not a valid image';
                        }
                        return null;

                      },
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                        onSaved: (value){
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              imageUrl: value,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite
                          );
                        }
                    ),
                  )
                ],
              )


            ],
          ),
        ),
      )
    );
  }
}

