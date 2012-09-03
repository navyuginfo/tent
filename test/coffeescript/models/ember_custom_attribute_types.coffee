require ('ember-data')

DS.attr.transforms.nativeDate = {
    from: (serialized) ->
        return serialized

    to: (deserialized) ->
        if (deserialized)
            return deserialized
        
        return null;
}