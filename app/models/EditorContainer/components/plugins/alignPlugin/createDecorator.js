import React, { Component } from 'react';
import ReactDOM from 'react-dom';

const getDisplayName = (WrappedComponent) => {
  const component = WrappedComponent.WrappedComponent || WrappedComponent;
  return component.displayName || component.name || 'Component';
};

export default ({ store }) => (WrappedComponent) => class BlockAlignmentDecorator extends Component {
  constructor(props) {
    super(props);
    
    this.displayName = `BlockDraggable(${getDisplayName(WrappedComponent)})`;
    this.WrappedComponent = WrappedComponent.WrappedComponent || WrappedComponent;
  }

  componentDidUpdate() {
    if (this.props.blockProps.isFocused && this.props.blockProps.isCollapsedSelection) {
      const blockNode = ReactDOM.findDOMNode(this);
      const boundingRect = blockNode.getBoundingClientRect();
      store.updateItem('setAlignment', this.props.blockProps.setAlignment);
      store.updateItem('alignment', this.props.blockProps.alignment);
      store.updateItem('boundingRect', boundingRect);
      store.updateItem('visibleBlock', this.props.block.getKey());
    } else if (store.getItem('visibleBlock') === this.props.block.getKey()) {
      store.updateItem('visibleBlock', null);
    }
  }

  componentWillUnmount() {
    store.updateItem('visibleBlock', null);
  }

  render() {
    const {
      blockProps,
      className,
      ...elementProps
    } = this.props;

    return (
      <WrappedComponent
        {...elementProps}
        blockProps={blockProps}
      />
    );
  }
};
