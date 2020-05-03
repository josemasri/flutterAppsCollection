import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/src/providers/product.provider.dart';
import 'package:flutter_complete_guide/src/providers/products.provider.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) {
      final regexp = RegExp(
          r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$");
      if (!regexp.hasMatch(_imageUrlController.text)) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    if (product != null) {
      _editedProduct = product;
      _imageUrlController.text = product.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _editedProduct.title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label),
                  alignLabelWithHint: true,
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: value,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                ),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                validator: (value) {
                  if (value.trim().length == 0) {
                    return 'Title can\'t be empty';
                  }
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                initialValue: _editedProduct.price.toString(),
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                textInputAction: TextInputAction.next,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: double.tryParse(value),
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                ),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a positive value';
                  }
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                initialValue: _editedProduct.description,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label),
                  alignLabelWithHint: true,
                ),
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: value,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please a description';
                  }
                  if (value.trim().length < 10) {
                    return 'Description needs at least 10 characters';
                  }
                  return null;
                },
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                    child: _imageUrlController.text.isEmpty
                        ? Center(child: Text('Enter a URL'))
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.image),
                          alignLabelWithHint: true,
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (value) => _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value,
                              isFavorite: _editedProduct.isFavorite,
                            ),
                        validator: (value) {
                          final regexp = RegExp(
                              r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$");
                          if (!regexp.hasMatch(value)) {
                            return 'Please enter a valid URL';
                          }
                          return null;
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
