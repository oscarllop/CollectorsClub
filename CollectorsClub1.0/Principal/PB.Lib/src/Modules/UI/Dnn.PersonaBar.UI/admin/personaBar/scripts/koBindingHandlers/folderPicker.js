'use strict';
define([
        'jquery',
        'knockout',
        '../../../../../Resources/Shared/components/DropDownList/dnn.DropDownList',
        '../../../../../Resources/Shared/scripts/dnn.DataStructures.js',
        '../../../../../Resources/Shared/scripts/TreeView/dnn.TreeView.js',
        '../../../../../Resources/Shared/scripts/TreeView/dnn.DynamicTreeView.js',
        '../../../../../Resources/Shared/scripts/dnn.jquery.extensions.js',
        '../../../../../Resources/Shared/scripts/dnn.extensions.js',
        '../../../../../js/dnn.servicesframework.js',
        '../../../../../Resources/Shared/scripts/jquery/dnn.jScrollbar.js',
        'css!../../../../../Resources/Shared/components/DropDownList/dnn.DropDownList.css'
],

function($, ko) {
    ko.bindingHandlers.folderPicker = {
        init: function (element, valueAccessor) {
            var koOptions = valueAccessor();
            var selectFolderCallback = koOptions.selectFolderCallback;
            var koElement = koOptions.koElement;
            var id = "#{0}".replace(/\{0\}/g, element.id);

            var selectFolderProxyCallback = function () {
                selectFolderCallback.call(koElement, this.selectedItem());
            };

            var options = {
                disabled: false,
                initialState: { 
                    selectedItem: koOptions.selectedFolder
                },
                services: {
                    moduleId: '',
                    serviceRoot: 'InternalServices',
                    getTreeMethod: 'ItemListService/GetFolders',
                    sortTreeMethod: 'ItemListService/SortFolders',
                    getNodeDescendantsMethod: 'ItemListService/GetFolderDescendants',
                    searchTreeMethod: 'ItemListService/SearchFolders',
                    getTreeWithNodeMethod: 'ItemListService/GetTreePathForFolder',
                    rootId: 'Root',
                    parameters: { }
                },
                onSelectionChangedBackScript: selectFolderProxyCallback
            };

            $.extend(true, options, koOptions.options);

            dnn.createDropDownList(id, options, {});

            var folderPicker = dnn[element.id];

            koElement.subscribe(function (folder) {
                folderPicker.selectedItem({ key: folder.FolderID, value: folder.FolderName });
            });
        }
    };
});
