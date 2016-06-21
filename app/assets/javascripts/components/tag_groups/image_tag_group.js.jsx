import EtherealTagGroup from '../../api/ethereal_tag_group.es6';
import TagGroupEditor from './tag_group_editor.es6.jsx';
import Image from '../../api/image.es6';
import NM from '../../api/global.es6';

class ImageTagGroup extends React.Component {
  constructor(props) {
    super(props);
    if (this.props.isNew) {
      var group = new EtherealTagGroup();
      this.state = {
        group: group,
        showSubmit: true
      };
    } else {
      this.state = {
        group: this.props.group,
        showSubmit: true
      };
    }
  }

  render() {
    var submit;
    if (this.state.showSubmit) {
      submit =  <button onClick={this.submit.bind(this)}>
        Submit
      </button>;
    }
    else {
      submit = <div></div>;
    }
    var className = "image-group-editor";
    if (! this.state.group.id ) {
      className += " new-group";
    }
    return <div className={className}>
      <TagGroupEditor
        key={0}
        tags={this.state.group.tags}
        group={this.state.group}
        onTagAdd={this.addTag.bind(this)}
        onTagRemove={this.removeTag.bind(this)}
        autofocus={true}
        onSubmit={this.submit.bind(this)}
        allowTagCreation={true}
        hideSubmit={this.hideSubmit.bind(this)}
        showSubmit={this.showSubmit.bind(this)}
      />
      {submit}
    </div>;
  }

  hideSubmit() {
    this.setState({
      showSubmit: false
    });
  }
  showSubmit() {
    this.setState({
      showSubmit: true
    });
  }

  addTag(tag) {
    var group = this.state.group;
    group.addTag(tag);
    this.setState({
      group: group,
      showSubmit: true
    });
  }

  removeTag(tag) {
    var group = this.state.group;
    group.removeTag(tag);
    this.setState({
      group: group,
      showSubmit: true
    });
  }

  submit() {
    if (this.state.group.id) {
      var url = "/images/" + this.props.group.image_id + "/tag_groups/";
      url += this.state.group.id;
      delete this.state.group["image"];
      console.log("putting to url", url);
      var tag_ids = this.state.group.tags.map((t) => t.id);
      var data = {
        tag_group: {
          tag_ids: tag_ids
        }
      };
      NM.putJSON(url, data, function() {
        console.log("Successfully edited.");
        window.location.reload();
      });
    }
    // new tag group
    else {
      var tag_ids = this.state.group.tags.map((t) => t.id);
      var data = {
        tag_group: {
          tag_ids: tag_ids
        }
      };
      var url = "/images/" + this.props.imageId + "/tag_groups";
      NM.postJSON(url, data, function() {
        console.log("That should have created another tag group");
        window.location.reload();
      });
    }
  }
}

document.addEventListener("turbolinks:load", function() {
  console.log("Event fires");
  var newButton = document.getElementById("add-tag-group-button");
  if (newButton) {
    newButton.addEventListener("click", function() {
      $("#image-details-left").addClass("hide-mobile");
      console.log("Adding a new tag group");
      ReactDOM.render(<ImageTagGroup 
        isNew={true}
        imageId={this.dataset.image_id}
      />, this.parentElement);
    });
  }
  var elements = document.getElementsByClassName("edit-generic-tag-group");
  for (var e = 0; e < elements.length; e++) {
    var element = elements[e];
    element.addEventListener("click", function() {
      Image.find(this.dataset.image_id, (img) => {
        console.log("Found an image");
        var group = img.groupWithId(this.dataset.group_id);
        ReactDOM.render(<ImageTagGroup group={group} />,
                        this.parentElement);
      });
    }.bind(element));
  }
});

document.addEventListener("turbolinks:before-render", function() {
  $(".image-group-editor").toArray().forEach(o => {
    ReactDOM.unmountComponentAtNode(o.parentNode);
  });
});
